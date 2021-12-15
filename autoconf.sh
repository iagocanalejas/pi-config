#!/bin/bash

# shellcheck source=config.cfg
source "config.cfg"

SCRIPT_DIR=$(pwd)
export SCRIPT_DIR

STATE_FILE="updated"

if ! [[ -f "$STATE_FILE" ]]; then
    echo "-------------------------------------------------"
    echo "Update raspberry"
    echo "-------------------------------------------------"
    sudo apt update -y
    sudo apt upgrade -y

    echo "-------------------------------------------------"
    echo "Install required packages"
    echo "-------------------------------------------------"
    sudo apt install -y libffi-dev libssl-dev python3-dev python3-pip git rsync

    echo "-------------------------------------------------"
    echo "Configure static ip"
    echo "-------------------------------------------------"
    echo "interface eth0" | sudo tee -a /etc/dhcpcd.conf > /dev/null
    echo "static ip_address=$ip/24" | sudo tee -a /etc/dhcpcd.conf > /dev/null
    echo "static routers=$router_ip" | sudo tee -a /etc/dhcpcd.conf > /dev/null
    echo "static domain_name_servers=$dns_ip 8.8.8.8 8.8.4.4" | sudo tee -a /etc/dhcpcd.conf > /dev/null

    echo "-------------------------------------------------"
    echo "Configure hostname"
    echo "-------------------------------------------------"
    echo "127.0.1.1      $hostname" | sudo tee -a /etc/hosts > /dev/null
    echo "$hostname" | sudo tee -a /etc/hostname > /dev/null

    echo "-------------------------------------------------"
    echo "Installing docker"
    echo "-------------------------------------------------"
    curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
    sudo sh /tmp/get-docker.sh

    echo "-------------------------------------------------"
    echo "Installing docker-compose"
    echo "-------------------------------------------------"
    pip3 install docker-compose

    echo "-------------------------------------------------"
    echo "Add 'pi' user to 'docker' group"
    echo "-------------------------------------------------"
    sudo usermod -aG docker pi
    echo docker version

    touch "$STATE_FILE"
    sudo reboot
fi

echo "-------------------------------------------------"
echo "Raspberry already updated"
echo "-------------------------------------------------"
if $pihole_enable
then 
    ./scripts/pihole.sh
fi

if $hass_enable
then 
    ./scripts/hass.sh
fi

if $samba_enable
then 
    ./scripts/samba.sh
fi

rm "$STATE_FILE"