#!/bin/sh

mkdir install
cd install
curl -L'#' -O https://dl.dropboxusercontent.com/u/21717/arch/prepare-machine.sh
curl -L'#' -o /etc/pacman.conf https://dl.dropboxusercontent.com/u/21717/arch/pacman.conf
curl -L'#' -O https://dl.dropboxusercontent.com/u/21717/arch/install-stage-1.sh
curl -L'#' -O https://dl.dropboxusercontent.com/u/21717/arch/poweroff.timer

chmod +x *.sh
#DISK=/dev/vda ./prepare-machine.sh

