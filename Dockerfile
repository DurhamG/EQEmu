FROM debian:12
RUN apt-get -y update
RUN apt-get -y install bash
RUN apt-get -y install build-essential
RUN apt-get -y install cmake
RUN apt-get -y install cpp
RUN apt-get -y install curl
RUN apt-get -y install debconf-utils
RUN apt-get -y install g++
RUN apt-get -y install gcc
RUN apt-get -y install git
RUN apt-get -y install git-core
RUN apt-get -y install libio-stringy-perl
RUN apt-get -y install liblua5.1
RUN apt-get -y install liblua5.1-dev
RUN apt-get -y install libluabind-dev
RUN apt-get -y install libmysql++
RUN apt-get -y install libperl-dev
RUN apt-get -y install minizip
RUN apt-get -y install lua5.1
RUN apt-get -y install make
RUN apt-get -y install mariadb-client
RUN apt-get -y install unzip
RUN apt-get -y install uuid-dev
RUN apt-get -y install wget
RUN apt-get -y install libsodium-dev
RUN apt-get -y install libjson-perl
RUN apt-get -y install libssl-dev

COPY . /source