#!/bin/bash

set -e
set -x

yes | sudo pacman -Scc

echo "Change user rights"
chown -R vagrant.vagrant /home/vagrant