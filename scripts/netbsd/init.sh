#!/bin/ksh

set -e
set -x

os=$(uname -s)
arch=$(uname -m)
release=$(uname -r|cut -f '1 2' -d.)

PATH="/usr/pkg/sbin:$PATH"
# export PKG_PATH="http://ftp.netbsd.org/pub/pkgsrc/packages/$(uname -s)/$(uname -m)/$(uname -r|cut -f '1 2' -d.)/All"
export PKG_PATH="http://ftp.netbsd.org/pub/pkgsrc/packages/$os/$arch/$release/All"
export PATH PKG_PATH

sudo pkg_admin -K /var/db/pkg fetch-pkg-vulnerabilities

sudo mkdir -p /usr/pkg/etc/pkgin
sudo touch /usr/pkg/etc/pkgin/repositories.conf

# echo "http://ftp.netbsd.org/pub/pkgsrc/packages/$(uname -s)/$(uname -m)/$(uname -r|cut -f '1 2' -d.)/All" | sudo tee /usr/pkg/etc/pkgin/repositories.conf
echo "http://ftp.netbsd.org/pub/pkgsrc/packages/$os/$arch/$release/All" | sudo tee /usr/pkg/etc/pkgin/repositories.conf
sudo pkgin -y update

# echo 'export PKG_PATH="http://ftp.netbsd.org/pub/pkgsrc/packages/$os/$arch/$release/All"'  | sudo tee /root/.cshrc
