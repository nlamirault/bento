#!/bin/sh

set -e
set -x

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks

tee -a /etc/ssh/sshd_config <<EOF

UseDNS no
EOF
