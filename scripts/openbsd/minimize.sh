#!/bin/ksh

set -e
set -x

dd if=/dev/zero of=/tmp/zero.bin
rm /tmp/zero.bin
echo "$(date): Disk cleanup completed."
