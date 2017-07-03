#!/bin/bash

echo "Setup Xorg"
setup-xorg-base
apk add xf86-video-vesa

echo "Install Xfce"
apk add xfce4 lxdm

echo "Install input packages"
apk add xf86-input-mouse xf86-input-keyboard

echo "Setup keyboard layout"
apk add setxkbmap
setxkbmap fr-fr

echo "Setup dbus"
rc-service dbus start
rc-update add dbus


rc-update add lxdm
