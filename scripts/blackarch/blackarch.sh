#!/usr/bin/env bash

set -e

TERM=${TERM:-xterm}
export TERM

# curl https://www.blackarch.org/strap.sh | bash
# curl -O https://blackarch.org/strap.sh
# chmod +x ./strap.sh
# sudo ./strap.sh

NUMPKGS=$(/usr/bin/yaourt -Ss blackarch | /usr/bin/grep -v "^    " | /usr/bin/wc -l)
echo "$NUMPKGS" BlackArch packages available.
