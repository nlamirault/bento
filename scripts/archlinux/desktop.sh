#!/bin/bash

echo "Install Xfce"
pacman -Sy xfce4 xfce4-goodies lightdm

echo "Configure X"
echo "exec startxfce4 --with-ck-launch" > /home/vagrant/.xinitrc
