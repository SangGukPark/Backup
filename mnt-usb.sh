#!/bin/bash

path=/mnt/usb
drive=`fdisk -l | egrep sdb[0-9]+ | cut -d " " -f 1`
mount -t vfat $drive $path
