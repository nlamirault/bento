#!/bin/bash

apt-get -y install language-pack-fr
sed -i 's/XKBLAYOUT=.*/XKBLAYOUT="us,fr"/g' /etc/default/keyboard
sed -i 's/XKBOPTIONS=.*/XKBOPTIONS="grp:ctrl_shift_toggle"/g' /etc/default/keyboard
