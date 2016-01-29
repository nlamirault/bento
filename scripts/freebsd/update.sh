#!/bin/sh -eux

major_version="`uname -r | awk -F. '{print $1}'`";

if [ "$major_version" -lt 10 ]; then
  # Allow freebsd-update to run fetch without stdin attached to a terminal
  sed 's/\[ ! -t 0 \]/false/' /usr/sbin/freebsd-update >/tmp/freebsd-update;
  chmod +x /tmp/freebsd-update;
  freebsd_update="/tmp/freebsd-update";
else
  freebsd_update="/usr/sbin/freebsd-update --not-running-from-cron";
fi

# Update FreeBSD
env PAGER=/bin/cat $freebsd_update fetch;
env PAGER=/bin/cat $freebsd_update install;

# Always use pkgng - pkg_add is EOL as of 1 September 2014
env ASSUME_ALWAYS_YES=true pkg bootstrap
if [ "$major_version" -lt 10 ]; then
    echo "WITH_PKGNG=yes" >>/etc/make.conf
fi

pkg update
