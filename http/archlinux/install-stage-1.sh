#!/bin/sh

FQDN='vbox-arch'
KEYMAP='us'
LANGUAGE='en_US.UTF-8'
PASSWORD=$(/usr/bin/openssl passwd -crypt 'vagrant')
TIMEZONE='UTC'

# configure hostname
echo "===> configuring hostname"
echo "${FQDN}" > /etc/hostname
/usr/bin/ln -s /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
hwclock --systohc --utc

# configure locales
echo "===> configuring locales"
echo 'KEYMAP=${KEYMAP}' > /etc/vconsole.conf
sed -i 's/#${LANGUAGE}/${LANGUAGE}/' /etc/locale.gen
locale-gen

echo "==> configuring network"
echo '[Match]
Name=eth* en*
[Network]
DHCP=yes
' > /etc/systemd/network/80-dhcp.network
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service

# install ssh server
echo "===> configuring ssh server"
sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
systemctl enable sshd.service

echo "===> creating vagrant user"
usermod -p ${PASSWORD} vagrant
# create vagrant user
useradd -m -U -s /bin/zsh -c 'Vagrant User' -G wheel -p ${PASSWORD} vagrant

echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/10_vagrant
chmod 0440 /etc/sudoers.d/10_vagrant
# configure vagrant user with ssh keys
install --directory --owner=vagrant --group=users --mode=0700 /home/vagrant/.ssh
curl -sL'#' --output /home/vagrant/.ssh/authorized_keys --location https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
chown vagrant:users /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys


echo "===> configuring cpio"
echo '
# vim:set ft=sh
MODULES="btrfs"
BINARIES=""
FILES=""
COMPRESSION="gzip"
HOOKS="base udev autodetect modconf block filesystems keyboard btrfs"
' > /etc/mkinitcpio.conf

mkinitcpio -p linux

echo "===> configuring bootloader"
grub-install --target=i386-pc --recheck ${DISK}
grub-mkconfig -o /boot/grub/grub.cfg
if [ -d /sys/firmware/efi ]; then
  esp=/boot/efi
  grub-install --target=x86_64-efi --efi-directory=$esp --bootloader-id=grub --boot-directory=$esp --recheck
  grub-mkconfig -o $esp/grub/grub.cfg
fi

echo "===> cleaning up"
pacman -Scc --noconfirm
