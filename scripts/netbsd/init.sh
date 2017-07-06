#!/bin/sh -ex

sed -I \
  -e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
  -e 's/^UsePam yes/UsePam no/' \
  -e 's/^#UseDNS no/UseDNS no/' \
  -e 's/^#NoneEnabled no/NoneEnabled yes/' /etc/ssh/sshd_config
