#!/bin/sh

# VirtualBox Guest Additions
pacman -S --noconfirm linux-headers virtualbox-guest-modules virtualbox-guest-utils mesa-libgl
systemctl enable vboxservice.service
usermod -a -G vboxsf vagrant

# Desktop
pacman -S --noconfirm xorg-server xorg-xinit xorg-server-utils slim i3-wm thunar xfce4
systemctl enable slim
