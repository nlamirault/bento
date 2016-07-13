#!/bin/sh

set -e
set -x

# sudo PATH="/usr/pkg/sbin:http://ftp.netbsd.org/pub/pkgsrc/packages/$(uname -s)/$(uname -m)/$(uname -r|cut -f '1 2' -d.)/All" pkgin -y install tdb samba gvfs xfce4-thunar xfce4-desktop xfce4

# sudo cp -f /usr/pkg/share/examples/rc.d/famd /etc/rc.d/
# sudo cp -f /usr/pkg/share/examples/rc.d/dbus /etc/rc.d/
# sudo cp -f /usr/pkg/share/examples/rc.d/hal /etc/rc.d/

# echo rpcbind=YES | sudo tee /etc/rc.conf
# echo famd=YES | sudo tee /etc/rc.conf
# echo dbus=YES | sudo tee /etc/rc.conf
# echo hal=YES | sudo tee /etc/rc.conf

# sudo /etc/rc.d/rpcbind start
# sudo /etc/rc.d/famd start
# sudo /etc/rc.d/dbus start
# sudo /etc/rc.d/hal start

echo "exec /usr/local/bin/startxfce4 --with-ck-launch" > ~/.xinitrc
echo '#!/bin/sh' > ~/.xsession
echo "exec /usr/local/bin/startxfce4 --with-ck-launch" >> ~/.xsession
chmod +x ~/.xsession
