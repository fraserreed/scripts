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

sudo apt-get update
sudo apt-get install realvnc-vnc-server realvnc-vnc-viewer
