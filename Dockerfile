FROM centos:7

RUN yum -y update && yum -y install gnupg ca-certificates
RUN yum -y update && yum -y install g++ sudo wget git vim && yum -y groupinstall 'Development Tools' && rm -rf /var/lib/apt/lists/*
RUN yum -y update && yum -y groupinstall "Development Tools"
RUN yum -y update && sudo yum install -y git gcc gcc-c++ libstdc++ gcc-gfortran glibc glibc-devel glib-static make blas-devel lapack lapack-devel atlas-devel zlib-devel libquadmath
RUN yum makecache
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum makecache
RUN yum -y install python36u
#Set up users
RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers
ARG userId
ARG groupId
RUN mkdir -p /home/developer && \
    echo "developer:x:$userId:$groupId:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:$userId:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown $userId:$groupId -R /home/developer

USER root
ENV HOME /home/developer
WORKDIR /home/developer
RUN git clone https://github.com/chenlab-uva/king_testing.git testing
WORKDIR /home/developer/testing
RUN  python3.6 test.py -v