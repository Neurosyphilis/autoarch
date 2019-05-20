#!/bin/bash

#Cкрипт для автоустановки Arch. Автор - Нейросифилис
cd configs
loadkeys ru
'setfont cyr-sun16'
cp -v locale.gen /etc/
locale-gen
export LANG=ru_RU.UTF-8
echo 'Разметка'
cfdisk /dev/sda
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
mkdir /mnt/boot /mnt/home /mnt/var
mount /dev/sda1 /mnt/boot
echo 'Выбор зеркал'
vim /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel
pacstrap /mnt grub-bios
genfstab -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
hwclock --systohc --utc
mkinitcpio -p linux
passwd root
read -p "Имя пользователя: " username
read -p "Имя Хоста: " hostname
useradd -mg users -G wheel -s /bin/bash $username
echo 'Пароль для пользователя'
passwd $username
echo 'Пароль для рута'
passwd root
echo $hostname > /etc/hostname
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
echo '%sudo ALL=(ALL) ALL' >> /etc/sudoers
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
sudo pacman -Syu
sudo pacman -S xorg xorg-server xorg-drivers xorg-xinit
sudo pacman -S mate mate-extra
sudo pacman -S lxdm --noconfirm
sudo pacman -S mc vim --noconfirm
sudo pacman -S git wget firefox vlc gimp pamac-aur
sudo pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update
wget git.io/yay-install.sh && sh yay-install.sh --noconfirm
systemctl enable lxdm
pacman -S ttf-liberation ttf-dejavu --noconfirm
systemctl enable dhcpcd
echo 'Готово'
