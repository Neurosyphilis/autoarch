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
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
hwclock --systohc --utc
passwd root
read -p "Username : " username
read -p "Hostname : " hostname
useradd -mg users -G wheel -s /bin/bash $username
passwd $username
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
vim /etc/sudoers
hostnamectl set-hostname $hostname
systemctl enable dhcpcd
exit
sudo reboot now
