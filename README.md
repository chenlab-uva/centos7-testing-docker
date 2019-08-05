# centos7-testing-docker

BUILD: ``sudo docker build --no-cache --build-arg userId=`id -u` --build-arg groupId=`id -g` -t centos7king .``      .

RUN: `sudo docker run -ti centos7king`.