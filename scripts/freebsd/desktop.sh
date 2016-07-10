#!/bin/sh -eux

sudo pkg update -f
sudo pkg install -y xorg slim xfce i3 i3lock i3status
echo "exec /usr/local/bin/startxfce4 --with-ck-launch" > ~/.xinitrc
echo "#!/bin/sh" > ~/.xsession
echo "exec /usr/local/bin/startxfce4 --with-ck-launch" >> ~/.xsession
chmod +x ~/.xsession

echo 'hald_enable="YES"' >> /etc/rc.conf
echo 'dbus_enable="YES"' >> /etc/rc.conf
echo 'moused_enable="YES"' >> /etc/rc.conf
echo 'slim_enable="YES"' >> /etc/rc.conf

# sudo Xorg -configure
# sudo cp /root/xorg.conf.new /usr/local/etc/X11/xorg.conf.d/xorg.conf
cat >>/usr/local/etc/X11/xorg.conf.d/xorg.conf << XORG_CONF

Section "ServerLayout"
	Identifier     "X.org Configured"
	Screen      0  "Screen0" 0 0
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
	ModulePath   "/usr/local/lib/xorg/modules"
	FontPath     "/usr/local/share/fonts/misc/"
	FontPath     "/usr/local/share/fonts/TTF/"
	FontPath     "/usr/local/share/fonts/OTF/"
	FontPath     "/usr/local/share/fonts/Type1/"
	FontPath     "/usr/local/share/fonts/100dpi/"
	FontPath     "/usr/local/share/fonts/75dpi/"
EndSection

Section "Module"
	Load  "glx"
EndSection

Section "InputDevice"
	Identifier  "Keyboard0"
	Driver      "kbd"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option	    "Protocol" "auto"
	Option	    "Device" "/dev/sysmouse"
	Option	    "ZAxisMapping" "4 5 6 7"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "Monitor Vendor"
	ModelName    "Monitor Model"
EndSection

Section "Device"
        ### Available Driver options are:-
        ### Values: <i>: integer, <f>: float, <bool>: "True"/"False",
        ### <string>: "String", <freq>: "<f> Hz/kHz/MHz",
        ### <percent>: "<f>%"
        ### [arg]: arg optional
        #Option     "ShadowFB"           	# [<bool>]
        #Option     "DefaultRefresh"     	# [<bool>]
        #Option     "ModeSetClearScreen" 	# [<bool>]
	Identifier  "Card0"
	Driver      "vesa"
	BusID       "PCI:0:2:0"
EndSection

Section "Screen"
	Identifier "Screen0"
	Device     "Card0"
	Monitor    "Monitor0"
	SubSection "Display"
		Viewport   0 0
		Depth     1
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     4
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     8
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     15
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     16
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     24
	EndSubSection
EndSection

XORG_CONF
