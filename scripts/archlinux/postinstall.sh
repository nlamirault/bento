#!/bin/bash

set -e
set -x

# setting hostname, locales, etc
hostnamectl set-hostname "bento"
localectl set-locale "LANG=en_US.UTF-8"
localectl set-keymap "fr"
localectl set-x11-keymap "fr"
timedatectl set-ntp true

#setting link to systemd-resolved
ln -sf /var/run/systemd/resolve/resolv.conf /etc/resolv.conf
