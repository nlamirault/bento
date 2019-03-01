#!/usr/bin/env bash

set -e
set -x

echo ">> Fix File Permissions"
chown root:root /
chmod 0755 /

echo ">> Add user: vagrant"
useradd vagrant
echo "vagrant:vagrant" | chpasswd -c SHA512

# echo ">> Configure vagrant ssh usage"
# mkdir -p /home/vagrant/.ssh
# chmod 0700 /home/vagrant/.ssh
# yes | xbps-install -Sy -R http://repo.voidlinux.eu/current curl
# curl -L https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -o /home/vagrant/.ssh/authorized_keys
# chmod 0600 /home/vagrant/.ssh/authorized_keys
# chown -R vagrant:vagrant /home/vagrant/.ssh

echo ">> Give vagrant passwordless sudo access"
echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# echo ">> Set root password to voidlinux"
# echo "root:voidlinux" | chpasswd -c SHA512

echo ">> Enable critical services"
ln -s /etc/sv/dhcpcd /etc/runit/runsvdir/default/dhcpcd
ln -s /etc/sv/sshd /etc/runit/runsvdir/default/sshd

echo ">> Install Virtualbox Guest Additions"
xbps-install -Sy -R http://alpha.us.repo.voidlinux.org/current virtualbox-ose-guest
ln -s /etc/sv/vboxservce /etc/runit/runsvdir/default/vboxservice

echo ">> Set hostname: bento"
echo "bento" > /etc/hostname

echo ">> Configure /etc/rc.conf"
echo 'HOSTNAME="bento"' > /etc/rc.conf
echo 'HARDWARECLOCK="UTC"' >> /etc/rc.conf
echo 'TIMEZONE="Europe/Paris"' >> /etc/rc.conf
echo 'KEYMAP="us"' >> /etc/rc.conf
echo "/dev/sda1	 /boot	ext4	defaults	0	2" >> /etc/fstab
echo "/dev/sda2	 /		ext4	defaults	0	1" >> /etc/fstab

echo ">> Configure locales"
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/default/libc-locales
xbps-reconfigure -f glibc-locales

#echo ">> Configure dracut"
#echo 'hostonly="yes"' >> /etc/dracut.conf

echo ">> Install grub"
grub-install /dev/sda

echo ">> Determine kernel version"
#linux_kernel=`xbps-query --regex -Rs '^linux[[:digit:]]\.[-0-9\._]*$' | cut -f2 -d' ' | sort -V | tail -n1`

echo ">> Configure Linux kernel"
xbps-reconfigure -f linux4.17 #${linux_kernel}

echo ">> /var permissions"
chmod 755 /var
