set -eux

apk add sudo
adduser $VAGRANT_USERNAME wheel

echo "Defaults exempt_group=wheel" > /etc/sudoers
echo "%wheel ALL=NOPASSWD:ALL" >> /etc/sudoers
