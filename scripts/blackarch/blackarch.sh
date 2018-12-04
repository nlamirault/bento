#!/usr/bin/env bash

set -eu

echo "Blackarch desktop"

# pacman -Ss blackarch-artwork blackarch-config-gtk blackarch-config-bash blackarch-config-i3 blackarch-config-x11 blackarch-config-lxdm

mkdir -p /usr/share/blackarch/artwork

echo "Blackarch config Grub"
mkdir -p /usr/share/blackarch/artwork/grub
curl -o /usr/share/blackarch/artwork/grub/splash.png \
    https://github.com/BlackArch/blackarch-artwork/blob/master/grub/splash.png
mkdir -p /boot/grub/
# cp /usr/share/blackarch/artwork/grub/splash.png /boot/grub/splash.png
# sed -i 's/Arch Linux/BlackArch Linux/g' /boot/grub/grub.cfg

echo "Blackarch wallpaper"
# mkdir -p /usr/share/blackarch/artwork/wallpaper
# curl -o /usr/share/blackarch/artwork/wallpaper/wallpaper-fog.jpg \
#     https://raw.githubusercontent.com/BlackArch/blackarch-artwork/master/wallpaper/wallpaper-fog.jpg
pacman -Sy --noconfirm blackarch-wallpaper

echo "Blackarch config GTK"
pacman -Sy --noconfirm blackarch-config-gtk
cp -r /usr/share/blackarch/config/gtk-2.0/* /usr/share/gtk-2.0

echo "Blackarch config Bash"
pacman -Sy --noconfirm blackarch-config-bash
cp /usr/share/blackarch/config/bash/bashrc /root/.bashrc
cp /usr/share/blackarch/config/bash/bash_profile /root/.bash_profile

echo "Blackarch config i3"
pacman -Sy --noconfirm blackarch-config-i3
mkdir -p /root/.config/i3
mkdir -p /home/vagrant/.config/i3
cp /usr/share/blackarch/config/i3/config /root/.config/i3/config
cp /usr/share/blackarch/config/i3/i3status.conf /root/.config/i3/i3status.conf
cp /usr/share/blackarch/config/i3/config /home/vagrant/.config/i3/config
cp /usr/share/blackarch/config/i3/i3status.conf /home/vagrant/.config/i3/i3status.conf

echo "Blackarch config X11"
pacman -Sy --noconfirm blackarch-config-x11
cp /usr/share/blackarch/config/x11/xprofile /etc/xprofile
cp /usr/share/blackarch/config/x11/Xresources /root/.Xresources
cp /usr/share/blackarch/config/x11/Xdefaults /root/.Xdefaults
cp /usr/share/blackarch/config/x11/Xresources /home/vagrant/.Xresources
cp /usr/share/blackarch/config/x11/Xdefaults /home/vagrant/.Xdefaults

echo "Blackarch config LXDM"
pacman -Sy --noconfirm blackarch-config-lxdm
cp -r /etc/lxdm-blackarch/* /etc/lxdm/
cp -r /usr/share/lxdm-blackarch/* /usr/share/lxdm/
cp -r /usr/share/xsessions-blackarch /usr/share/xsessions
# curl -o /etc/lxdm/lxdm.conf https://github.com/BlackArch/blackarch-iso/blob/master/live-iso/airootfs/etc/lxdm/lxdm.conf

echo "Blackarch menus"
pacman -Sy --noconfirm archlinux-xdg-menu blackarch-menus