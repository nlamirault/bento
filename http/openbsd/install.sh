#!/bin/sh -ex

cp /mnt/etc/ssh/sshd_config /tmp/sshd_config
sed '/^PermitRootLogin/s/ no$/ yes/' /tmp/sshd_config > /mnt/etc/ssh/sshd_config
rm /tmp/sshd_config

echo "installpath = http://ftp.fr.openbsd.org/pub/OpenBSD/$OPENBSD_RELEASE/packages/$OPENBSD_ARCH" > /etc/pkg.conf
