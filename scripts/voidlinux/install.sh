#!/usr/bin/env bash

set -e
set -x

if [ -e /dev/vda ]; then
  device=/dev/vda
elif [ -e /dev/sda ]; then
  device=/dev/sda
else
  echo "ERROR: There is no disk available for installation" >&2
  exit 1
fi

memory_size_in_kilobytes=$(free | awk '/^Mem:/ { print $2 }')
swap_size_in_kilobytes=$((memory_size_in_kilobytes * 2))
sfdisk "$device" <<EOF
label: dos
size=${swap_size_in_kilobytes}KiB, type=82
                                   type=83, bootable
EOF

mkswap "${device}1"
mkfs.btrfs -L "rootfs" "${device}2"
mount "${device}2" /mnt

echo Y | xbps-install -SR http://repo.voidlinux.eu/current -yr /mnt \
                      base-voidstrap \
                      grub \
                      base-system \
                      lvm2 \
                      grub \
                      lsof \
                      curl

cp -a /etc/resolv.conf /mnt/etc/resolv.conf

xbps-alternatives -g sh -s dash

# umount /mnt
