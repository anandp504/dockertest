FROM dockerreg.ewr004.collective-media.net:5000/collective-centos:7.3
MAINTAINER Collective Media

RUN yum -y upgrade
RUN yum -y install wget

## 1. Installing Java / Dev tools

RUN wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo

RUN yum install -y \
    tar \
    unzip \
    apache-maven \
    git \
    && yum clean all

## 2. Install Oracle Java 8

ENV JAVA_VERSION  8u112
ENV JDK_VERSION   jdk1.8.0_112
ENV BUILD_VERSION b16

# Downloading Java
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm

RUN yum -y localinstall /tmp/jdk-8-linux-x64.rpm

RUN rm -R -f /tmp/*

ENV JAVA_HOME /usr/java/$JDK_VERSION

RUN alternatives --install /usr/bin/java java /usr/java/$JDK_VERSION/jre/bin/java 1
RUN alternatives --install /usr/bin/javac javac /usr/java/$JDK_VERSION/bin/javac 1
RUN alternatives --set java /usr/java/$JDK_VERSION/jre/bin/java
RUN alternatives --set javac /usr/java/$JDK_VERSION/bin/javac

## 3. Install Java Security Extension

RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip"
RUN unzip jce_policy-8.zip
RUN cp -rf /UnlimitedJCEPolicyJDK8/*.jar /usr/java/latest/jre/lib/security
RUN rm -R -f /UnlimitedJCEPolicyJDK8 /jce_policy-8.zip