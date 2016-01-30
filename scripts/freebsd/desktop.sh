#!/bin/sh -eux

sudo pkg update -f
sudo pkg install -y xorg slim xfce i3 i3lock i3status
echo "exec /usr/local/bin/startxfce4 --with-ck-launch" > ~/.xinitrc
echo "#!/bin/sh" > ~/.xsession
echo "exec /usr/local/bin/startxfce4 --with-ck-launch" >> ~/.xsession
chmod +x ~/.xsession

echo 'hald_enable=""YES"' >> /etc/rc.conf
echo 'dbus_enable="YES"' >> /etc/rc.conf
echo 'moused_enable="YES"' >> /etc/rc.conf
echo 'slim_enable="YES"' >> /etc/rc.conf
