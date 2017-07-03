#!/bin/bash

set -e
set -x

echo "Load customization: $1"
. "$1"

if [ -e /dev/vda ]; then
  device=/dev/vda
elif [ -e /dev/sda ]; then
  device=/dev/sda
else
  echo "ERROR: There is no disk available for installation" >&2
  exit 1
fi
export device

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

cp /etc/pacman.d/mirrorlist /tmp/mirrorlist.backup
sed -i 's/^#Server/Server/' /tmp/mirrorlist.backup
rankmirrors -vn 6 /tmp/mirrorlist.backup > /etc/pacman.d/mirrorlist

pacstrap /mnt base grub openssh sudo polkit btrfs-progs
swapon "${device}1"
genfstab -p /mnt >> /mnt/etc/fstab
swapoff "${device}1"

cp /tmp/install-chroot.sh /mnt/root/
arch-chroot /mnt sh -ex /root/install-chroot.sh

rm /mnt/root/install-chroot.sh

sed \
  -e 's/^PermitRootLogin .*/PermitRootLogin no/' \
  -e 's/^#PubkeyAuthentication .*/PubkeyAuthentication yes/' \
  -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' \
  -e 's/^#UseDNS .*/UseDNS no/' /mnt/etc/ssh/sshd_config > /tmp/sshd_config
mv /tmp/sshd_config /mnt/etc/ssh/sshd_config

umount -R /mnt

reboot
