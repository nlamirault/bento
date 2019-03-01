#!/bin/sh -eux

# Set the time correctly
ntpdate -v -b 0.freebsd.pool.ntp.org;

# Install sudo, curl and ca_root_nss
pkg install -y curl;
pkg install -y wget;
pkg install -y ca_root_nss;

# Emulate the ETCSYMLINK behavior of ca_root_nss; this is for FreeBSD 10,
# where fetch(1) was massively refactored and doesn't come with
# SSL CAcerts anymore
ln -sf /usr/local/share/certs/ca-root-nss.crt /etc/ssl/cert.pem;

# As sharedfolders are not in defaults ports tree, we will use NFS sharing
cat >>/etc/rc.conf << RC_CONF
# ZFS
zfs_enable="YES"

# SSH
sshd_enable="YES"

# Virtualbox
vboxguest_enable="YES"
vboxservice_enable="YES"

# NFS
rpcbind_enable="YES"
nfs_client_enable="YES"

RC_CONF

# Disable X11 because Vagrants VMs are (usually) headless
# cat >>/etc/make.conf << MAKE_CONF
# WITHOUT_X11="YES"
# MAKE_CONF
