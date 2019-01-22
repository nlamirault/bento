#!/bin/bash

set -e
set -x

sudo yum -y install epel-release
sudo yum -y install ansible

# sudo yum -y install wget
# wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-7.noarch.rpm
# rpm -ivh epel-release-7-7.noarch.rpm

# sudo yum -y install bzip2
# sudo yum -y --enablerepo=epel install dkms
# sudo yum -y install kernel-devel
# sudo yum -y install make
# sudo yum -y install perl

# # Uncomment this if you want to install Guest Additions with support for X
# #sudo yum -y install xorg-x11-server-Xorg

# # In CentOS 6 or earlier, dkms package provides SysV init script called
# # dkms_autoinstaller that is enabled by default
# if systemctl list-unit-files | grep -q dkms.service; then
#   sudo systemctl start dkms
#   sudo systemctl enable dkms
# fi

# sudo mount -o loop,ro ~/VBoxGuestAdditions.iso /mnt/
# sudo /mnt/VBoxLinuxAdditions.run || :
# sudo umount /mnt/
# rm -f ~/VBoxGuestAdditions.iso
