#!/bin/sh -eux

# sudo pkg update -f

# Install Xorg
pkg install -y xorg xdm xterm xf86-video-intel

# Install window managers
pkg install -y i3 i3status i3lock dmenu rofi
pkg install -y ${XFCE:-"xfce-4.12_1"} ${ARANDR:-"arandr-0.1.9"}


pw groupmod wheel -m ${VAGRANT_USER:=vagrant}
pw groupmod video -m ${VAGRANT_USER:=vagrant}

cat >> /etc/X11/xorg.conf << EOF
Section "Module"
	Load "freetype"
EndSection

Section "Files"
	FontPath "/usr/local/share/fonts/dejavu/"
EndSection
EOF

cat >> /usr/local/etc/X11/xorg.conf.d/keyboard.conf << EOF
Section "InputDevice"
  Identifier "Keyboard0"
  Driver "kbd"
  Option "XkbLayout" "fr"
  Option "XkbOptions" "terminate:ctrl_alt_bksp,ctrl:nocaps"
EndSection
EOF

echo "exec /usr/local/bin/i3" > /home/$VAGRANT_USER/.xinitrc
echo ". /usr/local/etc/xdg/xfce4/xinitrc" > /home/$VAGRANT_USER/.xinitrc
chown $VAGRANT_USER:${VAGRANT_GROUP:=vagrant} /home/$VAGRANT_USER/.xinitrc

echo ". /usr/local/etc/xdg/xfce4/xinitrc" > /home/$VAGRANT_USER/.xsession
# cat > /home/$VAGRANT_USER/.xsession << EOF
# #!/bin/sh
# exec /usr/local/bin/startxfce4 --with-ck-launch
# EOF
chown $VAGRANT_USER:$VAGRANT_GROUP /home/$VAGRANT_USER/.xsession
chmod +x /home/$VAGRANT_USER/.xsession

pkg install -y $SLIM $SLIM_THEMES
echo 'slim_enable="YES"' >> /etc/rc.conf

cp /usr/local/etc/slim.conf /usr/local/etc/slim.conf.orig
sed '/current_theme/s/default/fbsd/' /usr/local/etc/slim.conf.orig > /usr/local/etc/slim.conf

# Enable DBUS
echo "dbus_enable=YES" >> /etc/rc.conf
