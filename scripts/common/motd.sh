#!/bin/bash -eux

BENTO_VERSION=$(grep "VERSION=" Makefile |sed -e 's/[A-Z="]//g')

echo "==> Recording box generation date"
date > /tmp/vagrant_box_build_date

echo "==> Customizing message of the day"
MOTD_FILE=/tmp/motd
BANNER_WIDTH=64

# PLATFORM_RELEASE=$(lsb_release -sd)
# PLATFORM_MSG=$(printf '%s' "$PLATFORM_RELEASE")
PLATFORM_OS=$(uname -s);
PLATFORM_RELEASE=$(uname -r);
PLATFORM_ARCH=$(uname -m);
PLATFORM_MSG=$(printf '%s' "$PLATFORM_OS $PLATFORM_RELEASE $PLATFORM_ARCH")

BUILT_MSG=$(printf 'built %s' $(date +%Y-%m-%d))

printf '%0.1s' "-"{1..64} > ${MOTD_FILE}
# printf '\n' >> ${MOTD_FILE}
printf '
   __   ___      ___  __
  |__) |__  |\ |  |  /  \
  |__) |___ | \|  |  \__/      v%s' "${BENTO_VERSION}" >> ${MOTD_FILE}
printf '\n' >> ${MOTD_FILE}
printf '%0.1s' "-"{1..64} >> ${MOTD_FILE}
printf '\n' >> ${MOTD_FILE}

printf '%2s%-30s%30s\n' " " "${PLATFORM_MSG}" "${BUILT_MSG}" >> ${MOTD_FILE}
printf '%0.1s' "-"{1..64} >> ${MOTD_FILE}
printf '\n' >> ${MOTD_FILE}
mv ${MOTD_FILE} /etc/motd
