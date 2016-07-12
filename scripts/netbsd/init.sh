#!/bin/ksh

set -e
set -x

PATH="/usr/pkg/sbin:$PATH"
export PKG_PATH="http://ftp.netbsd.org/pub/pkgsrc/packages/$(uname -s)/$(uname -m)/$(uname -r|cut -f '1 2' -d.)/All"
export PATH PKG_PATH

sudo pkg_admin -K /var/db/pkg fetch-pkg-vulnerabilities

sudo mkdir -p /usr/pkg/etc/pkgin
sudo touch /usr/pkg/etc/pkgin/repositories.conf
echo "http://ftp.netbsd.org/pub/pkgsrc/packages/$(uname -s)/$(uname -m)/$(uname -r|cut -f '1 2' -d.)/All" | sudo tee /usr/pkg/etc/pkgin/repositories.conf

# sudo pkg_add -v pkgin
sudo pkgin update

# # sudo pkgin install xfce4

echo 'setenv PKG_PATH "ftp://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/`uname -m`/7.0/All"'  | sudo tee /root/.cshrc
