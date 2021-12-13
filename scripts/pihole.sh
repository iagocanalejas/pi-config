#!/bin/bash

################################################
# THIS SCRIPT NEEDS TO BE RUN FROM ROOT FOLDER #
################################################

# shellcheck source=../config.cfg
source "config.cfg"

DIR="$config_dir/pi-hole"
TIMEZONE="${timezone//\//\\/}"

echo "-------------------------------------------------"
echo "Configure Pi-Hole"
echo "-------------------------------------------------"
mkdir -p $DIR
sudo chmod 755 $DIR

echo "-------------------------------------------------"
echo "Prepare docker-compose"
echo "-------------------------------------------------"
cp dockerfiles/pi-hole-docker-compose.yml $DIR/docker-compose.yml

sed -i "s/hostname:/hostname:\ ${pihole_hostname}/g" $DIR/docker-compose.yml
sed -i "s/TZ:/TZ:\ ${TIMEZONE}/g" $DIR/docker-compose.yml
sed -i "s/WEBPASSWORD:/WEBPASSWORD:\ ${pihole_password}/g" $DIR/docker-compose.yml

sudo chmod 640 $DIR/docker-compose.yml

echo "-------------------------------------------------"
echo "Run docker-compose"
echo "-------------------------------------------------"

cd "$DIR" || exit
docker-compose up -d
cd "$SCRIPT_DIR" || exit
