CDH_VERSION=4
CDH_CUSTOMER_PATCH=0
PREV_RELEASE_TAG=pre-cdh4-base
export IVY_MIRROR_PROP=http://azov01.sf.cloudera.com:8081/artifactory/cloudera-mirrors/

CDH_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package

# Bigtop-utils
BIGTOP_UTILS_NAME=bigtop-utils
BIGTOP_UTILS_RELNOTES_NAME=Bigtop-utils
BIGTOP_UTILS_PKG_NAME=bigtop-utils
BIGTOP_UTILS_BASE_VERSION=0.4
BIGTOP_UTILS_RELEASE_VERSION=1
BIGTOP_UTILS_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package
BIGTOP_UTILS_BASE_REF=cdh4-base-$(BIGTOP_UTILS_BASE_VERSION)
BIGTOP_UTILS_BUILD_REF=HEAD
BIGTOP_UTILS_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
$(eval $(call PACKAGE,bigtop-utils,BIGTOP_UTILS))

# Bigtop-jsvc
BIGTOP_JSVC_NAME=bigtop-jsvc
BIGTOP_JSVC_RELNOTES_NAME=Apache Commons Daemon (jsvc)
BIGTOP_JSVC_PKG_NAME=bigtop-jsvc
BIGTOP_JSVC_BASE_VERSION=1.0.10
BIGTOP_JSVC_PKG_VERSION=1.0.10
BIGTOP_JSVC_RELEASE_VERSION=1
BIGTOP_JSVC_TARBALL_ONLY=true
BIGTOP_JSVC_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package
BIGTOP_JSVC_BASE_REF=cdh4-base-$(BIGTOP_UTILS_BASE_VERSION)
BIGTOP_JSVC_TARBALL_SRC=commons-daemon-$(BIGTOP_JSVC_BASE_VERSION)-native-src.tar.gz
BIGTOP_JSVC_TARBALL_DST=commons-daemon-$(BIGTOP_JSVC_BASE_VERSION).tar.gz
BIGTOP_JSVC_SITE=$(CLOUDERA_ARCHIVE)
BIGTOP_JSVC_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
$(eval $(call PACKAGE,bigtop-jsvc,BIGTOP_JSVC))

# Bigtop-tomcat
BIGTOP_TOMCAT_NAME=bigtop-tomcat
BIGTOP_TOMCAT_RELNOTES_NAME=Apache Tomcat
BIGTOP_TOMCAT_PKG_NAME=bigtop-tomcat
BIGTOP_TOMCAT_BASE_VERSION=6.0.35
BIGTOP_TOMCAT_PKG_VERSION=6.0.35
BIGTOP_TOMCAT_RELEASE_VERSION=1
BIGTOP_TOMCAT_TARBALL_ONLY=true
BIGTOP_TOMCAT_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package
BIGTOP_TOMCAT_BASE_REF=cdh4-base-$(BIGTOP_UTILS_BASE_VERSION)
BIGTOP_TOMCAT_TARBALL_SRC=apache-tomcat-$(BIGTOP_TOMCAT_BASE_VERSION)-src.tar.gz
BIGTOP_TOMCAT_TARBALL_DST=apache-tomcat-$(BIGTOP_TOMCAT_BASE_VERSION).tar.gz
BIGTOP_TOMCAT_SITE=$(CLOUDERA_ARCHIVE)
BIGTOP_TOMCAT_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
$(eval $(call PACKAGE,bigtop-tomcat,BIGTOP_TOMCAT))

# Hadoop
HADOOP_NAME=hadoop
HADOOP_RELNOTES_NAME=Apache Hadoop
HADOOP_PKG_NAME=hadoop
HADOOP_BASE_VERSION=2.0.0
HADOOP_RELEASE_VERSION=1
HADOOP_TARBALL_DST=hadoop-2.0.0-alpha-rc0-b08b945.tar.gz
HADOOP_TARBALL_SRC=$(HADOOP_TARBALL_DST)
HADOOP_SITE=$(CLOUDERA_ARCHIVE)
HADOOP_GIT_REPO=$(REPO_DIR)/cdh4/hadoop
HADOOP_BASE_REF=cdh4-base-$(HADOOP_BASE_VERSION)
HADOOP_BUILD_REF=HEAD
HADOOP_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
$(eval $(call PACKAGE,hadoop,HADOOP))

# Hadoop 0.20.0-based hadoop package
HADOOP_MR1_NAME=mr1
HADOOP_MR1_RELNOTES_NAME=Apache Hadoop
HADOOP_MR1_PKG_NAME=hadoop-0.20-mapreduce
HADOOP_MR1_BASE_VERSION=2.0.0-mr1
HADOOP_MR1_RELEASE_VERSION=1
HADOOP_MR1_TARBALL_DST=hadoop-0.20.2-r916569.tar.gz
HADOOP_MR1_TARBALL_SRC=$(HADOOP_MR1_TARBALL_DST)
HADOOP_MR1_SITE=$(CLOUDERA_ARCHIVE)
HADOOP_MR1_GIT_REPO=$(REPO_DIR)/cdh4/mr1
HADOOP_MR1_BASE_REF=cdh-base-0.20.2
HADOOP_MR1_BUILD_REF=HEAD
HADOOP_MR1_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
$(eval $(call PACKAGE,$(HADOOP_MR1_NAME),HADOOP_MR1))

# ZooKeeper
ZOOKEEPER_NAME=zookeeper
ZOOKEEPER_RELNOTES_NAME=Apache Zookeeper
ZOOKEEPER_PKG_NAME=zookeeper
ZOOKEEPER_BASE_VERSION=3.4.3
ZOOKEEPER_RELEASE_VERSION=1
ZOOKEEPER_TARBALL_DST=zookeeper-$(ZOOKEEPER_BASE_VERSION).tar.gz
ZOOKEEPER_TARBALL_SRC=$(ZOOKEEPER_TARBALL_DST)
ZOOKEEPER_GIT_REPO=$(REPO_DIR)/cdh4/zookeeper
ZOOKEEPER_BASE_REF=cdh4-base-$(ZOOKEEPER_BASE_VERSION)
ZOOKEEPER_BUILD_REF=cdh4-$(ZOOKEEPER_BASE_VERSION)
ZOOKEEPER_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
ZOOKEEPER_SITE=$(CLOUDERA_ARCHIVE)
$(eval $(call PACKAGE,zookeeper,ZOOKEEPER))

# HBase
HBASE_NAME=hbase
HBASE_RELNOTES_NAME=Apache HBase
HBASE_PKG_NAME=hbase
HBASE_BASE_VERSION=0.92.1
HBASE_RELEASE_VERSION=1
HBASE_TARBALL_DST=hbase-$(HBASE_BASE_VERSION).tar.gz
HBASE_TARBALL_SRC=hbase-0.92.1.tar.gz
HBASE_GIT_REPO=$(REPO_DIR)/cdh4/hbase
HBASE_BASE_REF=cdh4-base-$(HBASE_BASE_VERSION)
HBASE_BUILD_REF=cdh4-$(HBASE_BASE_VERSION)
HBASE_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
HBASE_SITE=$(CLOUDERA_ARCHIVE)
$(eval $(call PACKAGE,hbase,HBASE))

# Pig
PIG_NAME=pig
PIG_RELNOTES_NAME=Apache Pig
PIG_PKG_NAME=pig
PIG_BASE_VERSION=0.9.2
PIG_RELEASE_VERSION=1
PIG_TARBALL_DST=pig-$(PIG_BASE_VERSION).tar.gz
PIG_TARBALL_SRC=$(PIG_TARBALL_DST)
PIG_GIT_REPO=$(REPO_DIR)/cdh4/pig
PIG_BASE_REF=cdh4-base-$(PIG_BASE_VERSION)
PIG_BUILD_REF=cdh4-$(PIG_BASE_VERSION)
PIG_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
PIG_SITE=$(CLOUDERA_ARCHIVE)
$(eval $(call PACKAGE,pig,PIG))

# Hive
HIVE_NAME=hive
HIVE_RELNOTES_NAME=Apache Hive
HIVE_PKG_NAME=hive
HIVE_BASE_VERSION=0.8.1
HIVE_RELEASE_VERSION=1
HIVE_TARBALL_DST=hive-$(HIVE_BASE_VERSION).tar.gz
HIVE_TARBALL_SRC=$(HIVE_TARBALL_DST)
HIVE_GIT_REPO=$(REPO_DIR)/cdh4/hive
HIVE_BASE_REF=cdh4-base-$(HIVE_BASE_VERSION)
HIVE_BUILD_REF=cdh4-$(HIVE_BASE_VERSION)
HIVE_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
HIVE_SITE=$(CLOUDERA_ARCHIVE)
HIVE_SRC_PREFIX=src/
$(eval $(call PACKAGE,hive,HIVE))

# # Sqoop
SQOOP_NAME=sqoop
SQOOP_RELNOTES_NAME=Sqoop
SQOOP_PKG_NAME=sqoop
SQOOP_BASE_VERSION=1.4.1
SQOOP_RELEASE_VERSION=1
SQOOP_TARBALL_DST=sqoop-$(SQOOP_BASE_VERSION).tar.gz
SQOOP_TARBALL_SRC=sqoop-$(SQOOP_BASE_VERSION)-incubating-src.tar.gz
SQOOP_GIT_REPO=$(REPO_DIR)/cdh4/sqoop
SQOOP_BASE_REF=cdh4-base-$(SQOOP_BASE_VERSION)
SQOOP_BUILD_REF=cdh4-$(SQOOP_BASE_VERSION)
SQOOP_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
SQOOP_SITE=$(CLOUDERA_ARCHIVE)
$(eval $(call PACKAGE,sqoop,SQOOP))

# Oozie
OOZIE_NAME=oozie
OOZIE_RELNOTES_NAME=Apache Oozie
OOZIE_PKG_NAME=oozie
OOZIE_BASE_VERSION=3.1.3
OOZIE_RELEASE_VERSION=1
OOZIE_TARBALL_DST=oozie-$(OOZIE_BASE_VERSION).tar.gz
OOZIE_TARBALL_SRC=$(OOZIE_TARBALL_DST)
OOZIE_GIT_REPO=$(REPO_DIR)/cdh4/oozie
OOZIE_BASE_REF=cdh4-base-$(OOZIE_BASE_VERSION)
OOZIE_BUILD_REF=cdh4-$(OOZIE_BASE_VERSION)
OOZIE_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
OOZIE_SITE=$(CLOUDERA_ARCHIVE)
$(eval $(call PACKAGE,oozie,OOZIE))

# Whirr
WHIRR_NAME=whirr
WHIRR_RELNOTES_NAME=Apache Whirr
WHIRR_PKG_NAME=whirr
WHIRR_BASE_VERSION=0.7.1
WHIRR_RELEASE_VERSION=1
WHIRR_TARBALL_DST=whirr-$(WHIRR_BASE_VERSION)-src.tar.gz
WHIRR_TARBALL_SRC=$(WHIRR_TARBALL_DST)
WHIRR_GIT_REPO=$(REPO_DIR)/cdh4/whirr
WHIRR_BASE_REF=cdh4-base-$(WHIRR_BASE_VERSION)
WHIRR_BUILD_REF=cdh4-$(WHIRR_BASE_VERSION)
WHIRR_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
WHIRR_SITE=$(CLOUDERA_ARCHIVE)
$(eval $(call PACKAGE,whirr,WHIRR))

# $(WHIRR_TARGET_PREP):
# 	mkdir -p $($(PKG)_SOURCE_DIR)
# 	$(BASE_DIR)/tools/setup-package-build \
# 	  $($(PKG)_GIT_REPO) \
# 	  $($(PKG)_BASE_REF) \
# 	  $($(PKG)_BUILD_REF) \
# 	  $($(PKG)_DOWNLOAD_DST) \
# 	  $($(PKG)_SOURCE_DIR) \
# 	  $($(PKG)_FULL_VERSION)
# 	cp $(WHIRR_GIT_REPO)/cloudera/base.gitignore $(WHIRR_SOURCE_DIR)/.gitignore
# 	touch $@

# # Flume
FLUME_NAME=flume
FLUME_RELNOTES_NAME=Flume
FLUME_PKG_NAME=flume
FLUME_BASE_VERSION=0.9.4
FLUME_RELEASE_VERSION=1
FLUME_TARBALL_DST=flume-$(FLUME_BASE_VERSION).tar.gz
FLUME_TARBALL_SRC=$(FLUME_TARBALL_DST)
FLUME_GIT_REPO=$(REPO_DIR)/cdh4/flume
FLUME_BASE_REF=cdh4-base-$(FLUME_BASE_VERSION)
FLUME_BUILD_REF=cdh4-$(FLUME_BASE_VERSION)+25
FLUME_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
FLUME_SITE=$(CLOUDERA_ARCHIVE)
$(eval $(call PACKAGE,flume,FLUME))

# Flume NG
FLUME_NG_NAME=flume-ng
FLUME_NG_RELNOTES_NAME=Flume NG
FLUME_NG_PKG_NAME=flume-ng
FLUME_NG_BASE_VERSION=1.1.0
FLUME_NG_PKG_VERSION=1.1.0
FLUME_NG_RELEASE_VERSION=1
FLUME_NG_GIT_REPO=$(REPO_DIR)/cdh4/flume-ng
FLUME_NG_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
FLUME_NG_BASE_REF=cdh4-base-$(FLUME_NG_BASE_VERSION)
FLUME_NG_BUILD_REF=cdh4-$(FLUME_NG_BASE_VERSION)
FLUME_NG_TARBALL_DST=$(FLUME_NG_NAME)-$(FLUME_NG_BASE_VERSION).tar.gz
FLUME_NG_TARBALL_SRC=flume-$(FLUME_NG_BASE_VERSION)-incubating.tar.gz
FLUME_NG_SITE=$(CLOUDERA_ARCHIVE)
$(eval $(call PACKAGE,flume-ng,FLUME_NG))

# Mahout
MAHOUT_NAME=mahout
MAHOUT_RELNOTES_NAME=Mahout
MAHOUT_PKG_NAME=mahout
MAHOUT_BASE_VERSION=0.6
MAHOUT_RELEASE_VERSION=1
MAHOUT_TARBALL_DST=mahout-distribution-$(MAHOUT_BASE_VERSION)-src.tar.gz
MAHOUT_TARBALL_SRC=$(MAHOUT_TARBALL_DST)
MAHOUT_GIT_REPO=$(REPO_DIR)/cdh4/mahout
MAHOUT_BASE_REF=cdh4-base-$(MAHOUT_BASE_VERSION)
MAHOUT_BUILD_REF=cdh4-$(MAHOUT_BASE_VERSION)
MAHOUT_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
MAHOUT_SITE=$(CLOUDERA_ARCHIVE)
$(eval $(call PACKAGE,mahout,MAHOUT))

# Hue
HUE_NAME=hue
HUE_RELNOTES_NAME=$(HUE_NAME)
HUE_PKG_NAME=$(HUE_NAME)
HUE_BASE_VERSION=2.0.0
HUE_RELEASE_VERSION=1
HUE_TARBALL_DST=$(HUE_NAME)-$(HUE_BASE_VERSION)-src.tar.gz
HUE_TARBALL_SRC=$(HUE_TARBALL_DST)
HUE_GIT_REPO=$(REPO_DIR)/cdh4/hue
HUE_BASE_REF=cdh4-base-$(HUE_BASE_VERSION)
HUE_BUILD_REF=cdh4-$(HUE_BASE_VERSION)
HUE_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
HUE_SITE=$(CLOUDERA_ARCHIVE)
$(eval $(call PACKAGE,hue,HUE))

# CDH parcel packages
CDH_PARCEL_NAME=cdh-parcel
CDH_PARCEL_RELNOTES_NAME=CDH-Parcel
CDH_PARCEL_BASE_VERSION=1.0
CDH_PARCEL_PKG_NAME=cdh-parcel-$(CDH_PARCEL_BASE_VERSION)
CDH_PARCEL_RELEASE_VERSION=1
CDH_PARCEL_TARBALL_DST=$(CDH_PARCEL_NAME)-$(CDH_PARCEL_BASE_VERSION).tar.gz
CDH_PARCEL_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-repos/apt
CDH_PARCEL_BASE_REF=cdh4-base-0.4
CDH_PARCEL_BUILD_REF=HEAD
CDH_PARCEL_PACKAGE_GIT_REPO=$(REPO_DIR)/cdh4/cdh-package/bigtop-packages/src
$(eval $(call PACKAGE,cdh-parcel,CDH_PARCEL))
CDH_PARCEL_PKG_VERSION=$(CDH_PARCEL_BASE_VERSION)

