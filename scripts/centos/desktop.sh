#!/bin/bash

sudo yum install xorg-x11-server-Xorg xorg-x11-xinit-session
sudo yum -y install xorg-x11-server-Xorg xorg-x11-drv-{evdev,intel,synaptics} xorg-x11-xinit xterm terminus-fonts
sudo yum -y group install lightdm xfce-desktop
