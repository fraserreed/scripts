#!/usr/bin/env bash

if [[ $EUID -ne 0 ]];
then
	echo "This script must be run as root."
	exit 1
fi

# capture OS
OS=$(uname -m)

if [[ $OS != armv* ]];
then
	echo "This script should only be run on a pi."
	exit
fi

# install nginx
apt-get update
apt-get -y install nginx

# install mysql
apt-get install mysql-server

# install php
apt-get -y install php7.0 php7.0-mysql php7.0-mcrypt php7.0-mbstring php7.0-fpm php7.0-cli
