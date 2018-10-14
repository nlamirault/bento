#!/usr/bin/env bash

set -e

/usr/bin/pacman-db-upgrade
/usr/bin/sync
/usr/bin/pacman -Syu

/usr/bin/pacman -Sy --noconfirm wget
/usr/bin/pacman -Sy --noconfirm sudo
/usr/bin/pacman -Sy --noconfirm pacman-contrib
# /usr/bin/pacman -Sy --noconfirm yay
