#!/bin/sh -ex

test -z "$RSYNC" && RSYNC=rsync-3.1.2
test -z "$SUDO" && SUDO=sudo-1.8.15
pkg_add $RSYNC $SUDO

mkdir -p /home/${VAGRANT_USER:=vagrant}/.ssh
ftp -o - "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub" >> /home/$VAGRANT_USER/.ssh/authorized_keys
chown -R $VAGRANT_USER:${VAGRANT_GROUP:-vagrant} /home/$VAGRANT_USER/.ssh
chmod -R go-rwx /home/$VAGRANT_USER/.ssh

echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /usr/pkg/etc/sudoers.d/$VAGRANT_USER

exit
