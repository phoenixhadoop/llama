# Copyright (c) 2010 Cloudera, inc.

import boto
import cloudera.aws.ec2
import cloudera.staging.Archive
import cloudera.staging.ArchiveManager
import cloudera.staging.ElasticIpManager
import cloudera.staging.StageManager
import cloudera.utils
import getpass
import os, re
import paramiko
import subprocess
import sys
import time
import tarfile

from cloudera.utils import display_message, verbose_print
from optparse import OptionParser


# s3cmd configuration file template
S3TEMPLATE = """[default]
access_key = %(access_key)s
acl_public = False
bucket_location = US
cloudfront_host = cloudfront.amazonaws.com
cloudfront_resource = /2008-06-30/distribution
default_mime_type = binary/octet-stream
delete_removed = False
dry_run = False
encoding = UTF-8
encrypt = False
force = False
get_continue = False
gpg_command = /usr/bin/gpg
gpg_decrypt = %%(gpg_command)s -d --verbose --no-use-agent --batch --yes --passphrase-fd %%(passphrase_fd)s -o %%(output_file)s %%(input_file)s
gpg_encrypt = %%(gpg_command)s -c --verbose --no-use-agent --batch --yes --passphrase-fd %%(passphrase_fd)s -o %%(output_file)s %%(input_file)s
gpg_passphrase =
guess_mime_type = True
host_base = s3.amazonaws.com
host_bucket = %%(bucket)s.s3.amazonaws.com
human_readable_sizes = False
list_md5 = False
preserve_attrs = True
progress_meter = True
proxy_host =
proxy_port = 0
recursive = False
recv_chunk = 4096
secret_key = %(secret_key)s
send_chunk = 4096
simpledb_host = sdb.amazonaws.com
skip_existing = False
use_https = True
verbosity = WARNING"""

# To be renamed ArchiveController ?
class Archive:

  # Base directory where all the action is going to be
  BASE_DIR = '/tmp'

  # Username to use for log in. ubuntu ami only allow ubuntu user
  USERNAME = 'ubuntu'

  GPG_ENV_VARIABLE = "GNUPGHOME=" + BASE_DIR + "/apt/gpg-home/"

  # Since we
  SSH_NO_STRICT_HOST_KEY_CHECKING_OPTION = '-o StrictHostKeyChecking=no'

  # Packages to be installed on the instance before proceeding to the staging
  PACKAGES_TO_INSTALL = ['gnupg-agent', 'gnupg2', 's3cmd']


  def __init__(self):

    # List of environment variables to use
    self.env = [Archive.GPG_ENV_VARIABLE]

    self.username= Archive.USERNAME


  def connect(self, hostname, key_file, username = USERNAME):
    """
    Establish a connection with the archive

    @param hostname Archive hostname
    @param key_file SSH private key filename
    @param username Username to use for login
    """

    self.username = username

    self.ssh = paramiko.SSHClient()
    self.ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    key = paramiko.RSAKey.from_private_key_file(key_file)
    self.ssh.connect(hostname=hostname, username=username, pkey=key)


  def execute(self, cmd, redirect_stdout_to_stderr=False):
    """
    Execute a remote command and print stdout and stderr to screen

    @param cmd Command to be executed
    @redirect_stdout_to_stderr Redirect stderr to stdout
    """

    executed_cmd = " ".join(self.env) + " " + cmd

    if redirect_stdout_to_stderr:
      executed_cmd = executed_cmd + ' 2>&1'

    print "EXECUTING: [%s]"%(executed_cmd)
    stdin, stdout, stderr = self.ssh.exec_command(executed_cmd)
    stdin.close()

    # XXX Needs to find a better way to multiplex stdout and stderr other than redirection
    for line in stdout:
      print line.strip()

    for line in stderr:
      print line.strip()

    stdout.close()
    stderr.close()


  def copy_scripts(self, host, key_file):
    """
    Copy scripts to update deb and yum repositories

    @param host destination hostname
    @param key_file SSH private key filename
    """

    display_message("Cleanup script area:")
    self.execute("rm -rf " + Archive.BASE_DIR + "/apt")
    self.execute("rm -rf " + Archive.BASE_DIR + "/yum")
    self.execute("rm -rf " + Archive.BASE_DIR + "/ec2_build")

    display_message("Copy apt related scripts:")
    subprocess.call(["scp", Archive.SSH_NO_STRICT_HOST_KEY_CHECKING_OPTION, '-i', key_file, '-r', '../../apt', self.username + '@' + host + ':' + Archive.BASE_DIR + '/apt'])

    display_message("Copy yum related scripts:")
    subprocess.call(["scp", Archive.SSH_NO_STRICT_HOST_KEY_CHECKING_OPTION, '-i', key_file, '-r', '../../yum', self.username + '@' + host + ':' + Archive.BASE_DIR + '/yum'])

    display_message("Copy ec2_build related scripts:")
    subprocess.call(["scp", Archive.SSH_NO_STRICT_HOST_KEY_CHECKING_OPTION, '-i', key_file, '-r', '../../ec2_build', self.username + '@' + host + ':' + Archive.BASE_DIR + '/ec2_build'])

  def install_packages(self):
    """
    Update instance and install extra packages needed for the archive deployment
    """

    # Update and install extra packages
    display_message("Update system:")
    self.execute("sudo apt-get update", True)
    self.execute("sudo apt-get -y upgrade", True)

    display_message("Install " + ", ".join(Archive.PACKAGES_TO_INSTALL))
    self.execute("sudo apt-get -y install " + ' '.join(Archive.PACKAGES_TO_INSTALL), True)

    # Create s3cmd config file
    display_message("Setup s3cmd configuration file")
    s3_config_content = S3TEMPLATE % {'access_key': os.getenv('AWS_ACCESS_KEY_ID'),
                         'secret_key': os.getenv('AWS_SECRET_ACCESS_KEY')}
    self.execute('echo "' + s3_config_content + '" > /home/' + self.username + '/.s3cfg')


  def get_gpg_env(self):
    """
    Retrieve gpg environment variable used for contacting gpg-agent
    and adds it to the global list of environment variables
    """

    display_message("Retrieve GPG environment variable")
    stdin, stdout, stderr = self.ssh.exec_command('cat ' + Archive.BASE_DIR + '/.gpg-agent-info')
    lines = [line for line in stdout]
    line =  "".join(lines)
    gpg_env = line.strip()

    self.env.append(gpg_env)


  def start_gpg(self):
    """
    Start gpg-agent
    """

    # user www-data needs access to our gpg home
    display_message("Setup gpg home directory")
    self.execute('chmod -R 777 ' + Archive.BASE_DIR + '/apt/gpg-home/')

    # Start gpg-agent
    # XXX Do not redirect stdout to stderr when starting gpg-agent.
    # Some weird issues would block the connection
    # Seems to be related to tty
    display_message("Start gpg-agent")
    self.execute('sudo -E -u www-data gpg-agent --daemon  --write-env-file "' + Archive.BASE_DIR + '/.gpg-agent-info" --homedir ' + Archive.BASE_DIR + '/apt/gpg-home/ --allow-preset-passphrase')


  def set_gpg_passphrase(self, passphrase):
    """
    Set GPG passphrase

    @param passphrase Passphrase
    """

    display_message("Set gpg passphrase")
    stdin, stdout, stderr = self.ssh.exec_command( ' sudo -E -u www-data ' + " ".join(self.env) + " " + '/usr/lib/gnupg2/gpg-preset-passphrase -v  --preset F36A89E33CC1BD0F71079007327574EE02A818DD')
    stdin.write(passphrase)
    stdin.close()
    lines = [line for line in stdout]
    stderr_lines = [line for line in stderr]
    line =  "".join(lines + stderr_lines)
    print line


  def update_deb_repo(self, build, cdh_release):
    """
    Start script to update debian repository

    @param build Build to be published
    """

    display_message("Clean up previous builds")
    self.execute(' sudo rm -rf ' + Archive.BASE_DIR + '/' + build, True)

    display_message("Update deb repository")
    self.execute(' sudo -E -u www-data ' + Archive.BASE_DIR + '/apt/update_repo.sh -s cloudera-freezer -b ' + build + ' -c ' + cdh_release + ' -r /var/www/archive_public/debian/', True)


  def update_yum_repo(self, build, cdh_release):
    """
    Start script to update red hat repository

    @param build Build to be published
    """

    cdh_version = re.match('cdh(\d+)', cdh_release).group(1)

    display_message("Update yum repository")
    self.execute(' sudo -E -u www-data ' + Archive.BASE_DIR + '/yum/update_repos.sh -s ' + Archive.BASE_DIR + '/' + build + '/ -c ' + cdh_version + ' -r /var/www/archive_public/redhat/', True)


  def finalize_staging(self, build, cdh_release):
    """
    Start program to finalize staging.
    It means copying the tarball, its changelog and docs

    @param build Build to be published
    """

    cdh_version = re.match('cdh(\d+)', cdh_release).group(1)

    display_message("Finalize staging")
    self.execute(' sudo -E -u www-data ' + Archive.BASE_DIR + '/ec2_build/bin/finalize-staging.sh -b '+ build + ' -c ' + cdh_version + ' -r /var/www/archive_public/', True)
