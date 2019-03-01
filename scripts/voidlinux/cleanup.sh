#!/usr/bin/env bash

set -e
set -x

rm -f /var/cache/xbps/*.xbps{,.sig}

# umount /mnt

# xbps-install -Sv -yr /mnt zerofree

# mount -o remount,ro /mnt
# zerofree /dev/disk/by-label/void-root
