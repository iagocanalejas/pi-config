#!/bin/bash

################################################
# THIS SCRIPT NEEDS TO BE RUN FROM ROOT FOLDER #
################################################

# shellcheck source=../config.cfg
source "config.cfg"

DIR="$config_dir/samba"

echo "-------------------------------------------------"
echo "Configure Samba"
echo "-------------------------------------------------"
mkdir -p $DIR
sudo chmod 755 $DIR
cp config/smb.config $DIR/smb.config

echo "-------------------------------------------------"
echo "Install required packages"
echo "-------------------------------------------------"
sudo apt -y install samba samba-common-bin

echo "-------------------------------------------------"
echo "Modify fstab"
echo "-------------------------------------------------"

echo "UUID=$samba_drive_id $samba_mount_in $samba_drive_dormat defaults 0 0" | sudo tee -a /etc/fstab > /dev/null

echo "-------------------------------------------------"
echo "Modify samba configuration"
echo "-------------------------------------------------"

# [Videos]
# comment = Videos
# path = /mnt/data
# browseable = yes
# guest ok = yes
# read only = yes
# write list = user
# create mask = 0755
sed -i "s/\[\]/\[${samba_folder}\]\/g" $DIR/smb.config
sed -i "s/comment\ =/comment\ =\ ${samba_folder}/g" $DIR/smb.config
sed -i "s/path\ =/path\ =\ ${samba_mount_in}/g" $DIR/smb.config
sed -i "s/write\ list\ =/write\ list\ =\ ${samba_readwrite_user}/g" $DIR/smb.config

# shellcheck disable=SC2002
cat config/smb.conf | sudo tee -a /etc/samba/smb.conf > /dev/null

echo "-------------------------------------------------"
echo "Run samba"
echo "-------------------------------------------------"
sudo systemctl enable smbd
sudo systemctl restart smbd
