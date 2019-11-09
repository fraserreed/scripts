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

# install apt-transport-https
apt-get update
apt-get upgrade
apt-get -y install apt-transport-https

# add the pi source for plexmediaserver
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -

PLEX_SOURCE="deb https://downloads.plex.tv/repo/deb public main"
PLEX_TARGET="/etc/apt/sources.list.d/plexmediaserver.list"

if [ ! -f $PLEX_TARGET ]; then
    touch $PLEX_TARGET
fi

grep -q -F "$PLEX_SOURCE" $PLEX_TARGET | echo "$PLEX_SOURCE" | sudo tee $PLEX_TARGET

# install plexmediaserver
apt-get update
apt-get -y install plexmediaserver

# update the user running plex
sed -i -e 's/PLEX_MEDIA_SERVER_USER=plex/PLEX_MEDIA_SERVER_USER=pi/g' /etc/default/plexmediaserver.prev

# restart the service
service plexmediaserver restart
