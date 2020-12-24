#!/bin/bash
# Void Linux post-install script

bypass() {
	doas -v
	while true;
	do
	  doas -n true
	  sleep 45
	  kill -0 "$$" || exit
	done 2>/dev/null &
}

echo "Starting Void Linux post-install script..."
sleep 3s
	bypass

clear

echo "Importing files from server..."
sleep 3s
	doas xbps-install -Sy git rsync
	doas rm -rvf ~/.*
	git clone https://github.com/beffiom/dotfiles/
	rsync -rav ~/void-post-installer/dotfiles/.* ~/
	doas rm -rvf ~/.git/
	mkdir ~/Videos ~/Devices ~/Devices/A:A_Drive ~/Downloads ~/Music
	mkdir ~/.config/rtorrent/.session ~/.config/rtorrent/watch ~/.config/rtorrent/downloads

clear

echo "Updating system..."
sleep 3s
	doas xbps-install -Syu

clear

echo "Installing packages..."
sleep 3s
	doas xbps-install -Sy xorg xf86-input-libinput xf86-input-synaptics xf86-video-fbdev xautolock xbacklight xclip xclipboard xinit xmodmap xscreensaver xwallpaper libva make gcc base-devel libX11-devel libXrandr-devel libXft-devel libXinerama-devel pkg-config
	doas xbps-install -Sy xf86-video-intel libva-intel-driver linux-firmware-intel
	doas xbps-install -Sy alsa-utils pulseaudio alsa-plugins-pulseaudio
	doas xbps-install -Sy bluez bluez-alsa libbluetooth
	doas xbps-install -Sy acpi acpid bash-completion NetworkManager networkmanager-dmenu curl dash dunst htop libnotify neovim pulsemixer redshift st-terminfo wget wpa_supplicant unclutter-xfixes hunspell hunspell-en_US mythes
	doas xbps-install -Sy p7zip libzip unzip zip
	doas xbps-install -Sy python3 python3-dbus python3-devel python3-pip python3-pyperclip
	doas xbps-install -Sy fontconfig noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf font-symbola ttf-ubuntu-font-family font-awesome breeze-purple-cursor-theme font-hack-ttf
	doas xbps-install -Sy bspwm compton polybar sxhkd
	doas xbps-install -Sy qutebrowser
	doas xbps-install -Sy ffmpeg ImageMagick maim sxiv
	doas xbps-install -Sy ffmpegthumbnailer ffmpegthumbs poppler vifm
    doas xbps-install -Sy mpv youtube-dl castero newsboat playerctl mpv-mpris
	doas xbps-install -Sy mpd mpc ncmpcpp inotify-tools rtorrent
	doas xbps-install -Sy zathura zathura-cb zathura-djvu zathura-pdf-mupdf
	doas xbps-install -Sy neofetch cmatrix
	doas xbps-install -Sy gtk+3 lxappearance Adapta
	doas xbps-install -Sy libvirt qemu virt-manager ebtables dnsmasq privoxy dnscrypt-proxy
	# doas xbps-install -Sy kodi kodi-addon-inputstream-adaptive kodi-addon-peripheral-joystick minetest retroarch ppsspp openrct2 dolphin-emu xonotic speed-dreams xmoto

	pip3 install bs4
	pip3 install urllib5
	pip3 install ueberzug
	pip3 install keepmenu
	pip3 install castero

	doas xbps-remove -Ry nano
	doas xbps-remove -Oo

clear

echo "Configuring system..."
sleep 3s

	doas ln -sf /etc/sv/dbus /var/service/
	doas ln -sf /etc/sv/alsa /var/service/
	doas ln -sf /etc/sv/acpid /var/service/
	doas ln -sf /etc/sv/cgmanager /var/service/
	doas ln -sf /etc/sv/upower /var/service/
	doas ln -sf /etc/sv/dhcpcd /var/service/
	doas ln -sf /etc/sv/pulseaudio /var/service/
	doas ln -sf /etc/sv/NetworkManager /var/service/
	doas ln -s /etc/sv/libvirtd /var/service/
	doas ln -s /etc/sv/virtlogd /var/service/
	doas ln -s /etc/sv/virtlockd /var/service/
	doas ln -sf /etc/sv/acpid /var/service

	doas ln -sf /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

	doas ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
	doas hwclock --systohc --localtime

	doas ln -s /bin/dash /bin/sh

	echo "LANG=en_US.UTF-8" >> /etc/locale.conf
	echo "LANG=en_US.UTF-8" >> /etc/environment
	locale-gen

	doas chmod +x ~/.local/bin/*
	doas chmod +x ~/.config/bspwm/*
	doas chmod +x ~/.config/sxhkd/*

	xmodmap ~/.config/appearance/Xmodmap

	# Finish
	cd ~/
	doas resolvconf -u

clear

echo "Adding user to some groups..."
sleep 3s
	doas usermod -aG input $USER
	doas usermod -aG audio $USER
	doas usermod -aG video $USER
	doas usermod -aG wheel $USER
	doas usermod -aG libvirt $USER
	doas usermod -aG kvm $USER
	doas usermod -aG pulse-access $USER

	doas xbps-install -Syu
clear

echo "Don't forget to install st, dmenu, and slock with doas make clean install"
