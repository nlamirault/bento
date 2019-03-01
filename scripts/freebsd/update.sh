#!/bin/sh -eux

major_version="`uname -r | awk -F. '{print $1}'`";

freebsd_update="/usr/sbin/freebsd-update --not-running-from-cron";

# Update FreeBSD
env PAGER=/bin/cat $freebsd_update fetch;
env PAGER=/bin/cat $freebsd_update install;

# Always use pkgng - pkg_add is EOL as of 1 September 2014
env ASSUME_ALWAYS_YES=true pkg bootstrap
if [ "$major_version" -lt 10 ]; then
    echo "WITH_PKGNG=yes" >>/etc/make.conf
fi

pkg update
