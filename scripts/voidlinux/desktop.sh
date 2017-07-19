#!/usr/bin/env bash

set -e
set -x

rm -f /var/cache/xbps/*.xbps{,.sig}
xbps-install -S -yr /mnt \
             xorg \
             xorg-apps \
             xorg-fonts \
             xdg-user-dirs

xbps-install -S -yr /mnt i3

xbps-install -S -yr /mnt lightdm-gtk3-greeter
ln -s /etc/sv/lightm /var/service
