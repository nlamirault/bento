#!/bin/sh -ex

sudo dd if=/dev/zero of=/tmp/zero.bin bs=1M
sudo rm /tmp/zero.bin
echo "$(date): Disk cleanup completed"
sync

exit
