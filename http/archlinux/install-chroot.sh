#!/bin/bash

set -e
set -x

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

echo ${VAGRANT_HOSTNAME:=archlinux} > /etc/hostname
echo "127.0.0.1	${VAGRANT_HOSTNAME}.localdomain	localhost" >> /etc/hosts

(echo ${ROOT_PASSWORD:=vagrant}; echo ${ROOT_PASSWORD}) | passwd

groupadd ${VAGRANT_GROUP:=${VAGRANT_USERNAME:=vagrant}}
useradd -m -g $VAGRANT_GROUP $VAGRANT_USERNAME
(echo ${VAGRANT_PASSWORD:=vagrant}; echo $VAGRANT_PASSWORD) | passwd $VAGRANT_USERNAME

mkdir -pm 700 /home/$VAGRANT_USERNAME/.ssh
curl https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub > /home/$VAGRANT_USERNAME/.ssh/authorized_keys
chown -R $VAGRANT_USERNAME:$VAGRANT_GROUP /home/$VAGRANT_USERNAME
chmod -R og-rwx /home/$VAGRANT_USERNAME/.ssh

echo y | pacman -S sudo
echo "$VAGRANT_USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$VAGRANT_USERNAME

echo y | pacman -S openssh
systemctl enable sshd.service

exit
