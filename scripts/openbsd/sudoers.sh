#!/bin/sh

set -e

pkg_add sudo--
echo "vagrant ALL=(ALL) NOPASSWD: SETENV: ALL" >> /etc/sudoers
