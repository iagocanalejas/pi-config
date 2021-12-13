#!/bin/bash

now=$(date +"%Y%m%d")

echo "Backing up pi@raspberrypi.local in ~/pi-$now.gz" 

eval "ssh pi@raspberrypi.local \"sudo dd if=/dev/mmcblk0 bs=1M | gzip -\" | dd of=~/pi-$now.gz"

echo "Success."