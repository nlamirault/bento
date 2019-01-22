#!/bin/sh

mount /dev/$HDD /mnt

sed -I \
  -e 's/^#PermitRootLogin no/PermitRootLogin yes/' \
  -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /mnt/etc/ssh/sshd_config

cat << EOF >> /mnt/etc/rc.conf
#critical_filesystems_local=/var
dhclient=YES
rpcbind=YES
nfs_client=YES
no_swap=YES
lockd=YES
statd=YES
hostname=$HOSTNAME
EOF

cat << EOF >  /etc/pkg_install.conf
PKG_PATH=http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/$NETBSD_PKG_INSTALL/All
EOF

umount /mnt

shutdown -r now
