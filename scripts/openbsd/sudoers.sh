#!/bin/sh

set -e

pkg_add sudo

echo "$VAGRANT_USER ALL=(ALL) NOPASSWD: SETENV: ALL" >> /etc/sudoers
chmod og-rwx /etc/sudoers
