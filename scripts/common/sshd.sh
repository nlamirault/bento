#!/bin/sh

set -e
set -x

tee -a /etc/ssh/sshd_config <<EOF

UseDNS no
EOF
