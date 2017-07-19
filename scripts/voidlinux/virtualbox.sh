#!/usr/bin/env bash

set -e
set -x

xbps-install -Sv -yr /mnt \
             dbus \
             virtualbox-ose-guest

ln -s /etc/sv/dbus /var/service
ln -s /etc/sv/vboxservice /var/service
