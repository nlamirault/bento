#!/usr/bin/env bash

set -eu

DISK='/dev/sda'
ROOT_PARTITION="${DISK}1"
CHROOT="/mnt"

CONFIG_SCRIPT='/usr/local/bin/arch-config.sh'
BI_PATH="/usr/share/blackarch-installer"

FQDN='blackarch'
KEYMAP='us'
TIMEZONE='UTC'
LANGUAGE='en_US.UTF-8'

PASSWORD=$(/usr/bin/openssl passwd -crypt 'vagrant')

Green='\e[0;32m'
Reset='\e[0m'


function msg () {
    echo -e "${Green}[+] $*${Reset}"
}

function mount_filesystem() {
    msg "Mounting ${ROOT_PARTITION} to ${CHROOT}"
    /usr/bin/mount -o noatime,errors=remount-ro ${ROOT_PARTITION} ${CHROOT}
}

function umount_filesystem() {
    msg "Unmounting filesystems"
    umount -Rf ${CHROOT} > /dev/null 2>&1
}

function prepare() {
    localectl set-keymap --no-convert ${KEYMAP}

    msg "Updating pacman database"
    pacman -Syy --noconfirm --noprogressbar
    pacman -S --noconfirm --needed pacman-contrib gptfdisk patch
}


function prepare_disk() {
    msg "Clearing partition table on ${DISK}"
    /usr/bin/sgdisk --zap ${DISK}

    msg "Destroying magic strings and signatures on ${DISK}"
    /usr/bin/dd if=/dev/zero of=${DISK} bs=512 count=2048
    /usr/bin/wipefs --all ${DISK}

    msg "Creating /root partition on ${DISK}"
    /usr/bin/sgdisk --new=1:0:0 ${DISK}

    msg "Setting ${DISK} bootable"
    /usr/bin/sgdisk ${DISK} --attributes=1:set:2

    msg "Creating /root filesystem (ext4)"
    # https://www.youtube.com/watch?v=isHYr-5VH-Q
    /usr/bin/mkfs.ext4 -O '^64bit' -m 0 -F -L root ${ROOT_PARTITION}
}

function bootstrap_install() {
    msg "Bootstrapping base installation"
    /usr/bin/pacstrap ${CHROOT} base base-devel
    /usr/bin/arch-chroot ${CHROOT} pacman -S --noconfirm gptfdisk openssh syslinux

    msg "Configuring and installing syslinux"
    /usr/bin/arch-chroot ${CHROOT} syslinux-install_update -i -a -m
    /usr/bin/sed -i 's/sda3/sda1/' "${CHROOT}/boot/syslinux/syslinux.cfg"
    /usr/bin/sed -i 's/TIMEOUT 50/TIMEOUT 10/' "${CHROOT}/boot/syslinux/syslinux.cfg"

    msg "Generating the filesystem table"
    /usr/bin/genfstab -p ${CHROOT} >> "${CHROOT}/etc/fstab"

    msg "Generating the system configuration script"
    /usr/bin/install --mode=0755 /dev/null "${CHROOT}${CONFIG_SCRIPT}"
}


function configure_system() {
    msg "Configuring system"

    cat <<-EOF > "${CHROOT}${CONFIG_SCRIPT}"
    #!/usr/bin/env bash

    set -e

	echo '${FQDN}' > /etc/hostname
	rm -f /etc/localtime
	/usr/bin/ln -s /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
	/usr/bin/hwclock --systohc --utc
	echo 'KEYMAP=${KEYMAP}' > /etc/vconsole.conf
	/usr/bin/sed -i 's/#${LANGUAGE}/${LANGUAGE}/' /etc/locale.gen
	/usr/bin/locale-gen
	echo 'LANG=${LANGUAGE}' > /etc/locale.conf
	/usr/bin/mkinitcpio -p linux
	/usr/bin/usermod --password ${PASSWORD} root

	# https://wiki.archlinux.org/index.php/Network_Configuration#Device_names
	/usr/bin/ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
	/usr/bin/ln -s '/usr/lib/systemd/system/dhcpcd@.service' '/etc/systemd/system/multi-user.target.wants/dhcpcd@eth0.service'

    # Configure SSHD
	/usr/bin/sed -i 's/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config
	/usr/bin/sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
	/usr/bin/systemctl enable sshd.service

	# VirtualBox Guest Additions
	/usr/bin/pacman -S --noconfirm virtualbox-guest-modules-arch
    /usr/bin/pacman -S --noconfirm virtualbox-guest-utils-nox

    # Vagrant-specific configuration
	/usr/bin/groupadd vagrant
	/usr/bin/useradd --password ${PASSWORD} --comment 'Vagrant User' --create-home --gid users --groups vagrant vagrant
    echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_vagrant
	echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_vagrant
	/usr/bin/chmod 0440 /etc/sudoers.d/10_vagrant

EOF

    msg "Entering chroot and configuring system"
    /usr/bin/arch-chroot ${CHROOT} ${CONFIG_SCRIPT}
    rm "${CHROOT}${CONFIG_SCRIPT}"

    /usr/bin/sleep 3
    /usr/bin/sync
}



function reboot_system() {
    msg "Rebooting"
    /usr/bin/systemctl reboot
}

function blackarch() {
    prepare
    prepare_disk
    mount_filesystem
    bootstrap_install
    configure_system
    umount_filesystem
    msg "Installation complete!"
    reboot_system
}

blackarch
