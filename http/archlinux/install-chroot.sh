#!/bin/bash

set -e
set -x

ln -sf /usr/share/zoneinfo/UTC /etc/localtime
sed -i -e 's/^#\(en_US.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# setting vagrant user credentials
echo -e 'vagrant\nvagrant' | passwd
useradd -m -U vagrant
echo -e 'vagrant\nvagrant' | passwd vagrant

# setting automatic authentication for any action requiring admin rights via Polkit
cat <<EOF > /etc/polkit-1/rules.d/49-nopasswd_global.rules
polkit.addRule(function(action, subject) {
    if (subject.isInGroup("vagrant")) {
        return polkit.Result.YES;
    }
});
EOF

# setting sudo for vagrant user
cat <<EOF > /etc/sudoers.d/vagrant
Defaults:vagrant !requiretty
vagrant ALL=(ALL) NOPASSWD: ALL
EOF
chmod 440 /etc/sudoers.d/vagrant

# install vagrant ssh key
install --directory --owner=vagrant --group=vagrant --mode=0700 /home/vagrant/.ssh
curl --output /home/vagrant/.ssh/authorized_keys --location https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys

# setup unpredictable kernel names
ln -s /dev/null /etc/systemd/network/99-default.link

# setup network
cat <<EOF > /etc/systemd/network/eth0.network
[Match]
Name=eth0

[Network]
DHCP=ipv4
EOF

# Configure SSHD
/usr/bin/sed -i 's/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config
/usr/bin/sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
/usr/bin/systemctl enable sshd.service

# enabling important services
/usr/bin/systemctl enable sshd.service
/usr/bin/systemctl enable systemd-networkd.service
/usr/bin/systemctl enable systemd-resolved.service

grub-install "$device"
sed -i -e 's/^GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=1/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
