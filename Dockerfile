FROM centos:centos6
MAINTAINER Simon Mirco

RUN rpm -i http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/epel-release-6-5.noarch.rpm
RUN yum -y install python-pip

RUN mkdir /etc/rax-autoscaler
RUN pip install rax-autoscaler

ADD files/boot.sh /usr/local/bin/autoscale-service
RUN chmod +x /usr/local/bin/autoscale-service

ADD files/logging.conf /etc/rax-autoscaler/logging.conf
