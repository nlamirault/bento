#!/bin/bash

set -e
set -x

echo "Install Xfce"
pacman -Sy --noconfirm xfce4 xfce4-goodies

echo "Configure X"
echo "exec startxfce4 --with-ck-launch" > /home/vagrant/.xinitrc
