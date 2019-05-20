#!/bin/bash
cfdisk /dev/sda
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
mkdir /mnt/boot /mnt/home /mnt/var
mount /dev/sda1 /mnt/boot
vim /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel grub-bios
