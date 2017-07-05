#!/bin/sh -eux

pkg install -y sudo;
echo "$VAGRANT_USER ALL=(ALL) NOPASSWD: ALL" >>/usr/local/etc/sudoers;
