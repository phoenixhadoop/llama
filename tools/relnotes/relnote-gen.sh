#!/bin/bash
#
# Wrapper to drive release note HTML generation. Run as
#
# sh relnote-gen.sh /home/eli/cdh/relnote           \
#    /home/eli/src/cloudera/hadoop1                 \
#    8078e70b8916fe53139b07a87c92f743be04ba0a..HEAD \
#    "CDH 2" 0.20.1 hadoop-0.20.1+169.56
#
# This will generate hadoop-0.20.1+169.56.releasenotes.html
# in /home/eli/cdh/relnote using the git repo located at
# /home/eli/src/cloudera/hadoop1 using the above range
# specification. The release version (CDH 2) and Apache base
# version (0.20.1) are only for HTML generation.
#

# Arguments:
# $1 Directory to generate release notes into
# $2 git source directory
# $3 git range specification to generate notes for
# $4 Release version eg "CDH 2"
# $5 Base Project verion eg "0.20.1"
# $6 CDH Project version eg "hadoop-0.20.1+169.56"
# $7 CDH Project Name ed "Apache Hadoop"
# $8 CDH Packaging repository source directory
# $9 Packaging git range
function relnote_gen {
  local gen_dir=$1
  local commit_log=$gen_dir/$6-changes.log
  local package_commit_log=$gen_dir/$6-package-changes.log
  local changes_file=$gen_dir/$6.CHANGES.txt
  local package_changes_file=$gen_dir/$6.package.CHANGES.txt
  local relnote_file=$gen_dir/$6.releasenotes.html
  echo "pushd $2 >& /dev/null"
  if [ ! -d $gen_dir ]; then
    mkdir -p $gen_dir
  fi
  pushd $2 >& /dev/null
  git log --pretty=oneline --no-color $3 > $commit_log
  git log --pretty=medium --no-color $3 > $changes_file
  popd >& /dev/null
  pushd $8 >& /dev/null
  git log --pretty=oneline --no-color $9 > $package_commit_log
  git log --pretty=medium --no-color $9 > $package_changes_file
  popd >& /dev/null
  python ./tools/relnotes/relnotegen.py -l $commit_log -r "$4" -a $5 -c $6 -n "$7" > $relnote_file
}

relnote_gen $1 $2 $3 "$4" $5 $6 "$7" $8 "$9"
