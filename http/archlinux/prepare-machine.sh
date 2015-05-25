#!/bin/sh

echo "=> Preparing Arch VM"
echo ""

echo "==> syncing package lists"
echo '
Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch
Server = http://mirrors.cdndepo.com/archlinux/$repo/os/$arch
' > /etc/pacman.d/mirrorlist
pacman -Syy
echo ""


# partition disks
echo "==> initializing disks"
sgdisk -Z -og ${DISK}

echo "===> bios boot"
sgdisk -n 1:2048:+2M -c 1:"BIOS Boot Partition" -t 1:ef02 ${DISK}

bpn=2
rpn=3
extrapkgs=
if [ -d /sys/firmware/efi ]; then
  echo "===> efi partition"
  sgdisk -n 2:`sgdisk -F ${DISK}`:+200M -c 2:"EFI System Partition" -t 2:ef00 ${DISK}
  bpn=3
  rpn=4
  extrapkgs=(efibootmgr efivar)
  mkfs.vfat -F32 ${DISK}2
fi

echo "===> boot partition"
sgdisk -n $bpn:`sgdisk -F ${DISK}`:+100M -c $bpn:"Linux /boot" -t $bpn:8300 ${DISK}
mkfs.ext4 ${DISK}$bpn


echo "===> root partition"
sgdisk -N $rpn -c $rpn:"Linux root" -t $rpn:8300 ${DISK}
mkfs.btrfs ${DISK}$rpn

# mount partitions
echo ""
echo "==> mounting filesystems"
echo "===> mounting root"
mount -o noatime,compress=lzo,ssd,discard,space_cache,autodefrag ${DISK}$rpn /mnt

echo "===> mounting /boot"
mkdir -p /mnt/boot
mount -o noatime,discard ${DISK}$bpn /mnt/boot

if [ -d /sys/firmware/efi ]; then
  echo "===> mounting efi partition"
  mkdir -p /mnt/boot/efi
  mount ${DISK}2 /mnt/boot/efi
fi

echo "==> installing minimal base for provisioning"
pacstrap /mnt base base-devel btrfs-progs grub zsh openssh ${extrapkgs[*]}

# generate fstab
echo "===> generating file system tables"
genfstab -U -p /mnt >> /mnt/etc/fstab
echo ""

install --mode=0755 install-stage-1.sh /mnt
arch-chroot /mnt /bin/bash /install-stage-1.sh

# http://comments.gmane.org/gmane.linux.arch.general/48739
# echo '==> adding workaround for shutdown race condition'
# install --mode=0644 poweroff.timer "/mnt/etc/systemd/system/poweroff.timer"
echo '==> configuring resolved'
mv /mnt/etc/resolv.conf /mnt/etc/resolv.conf.old
chroot /mnt ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

rm /mnt/install-stage-1.sh
echo "==> unmounting filesystems"
sync
umount -R /mnt
systemctl reboot
