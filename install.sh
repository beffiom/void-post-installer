#!/bin/bash
# Void Linux post-install script

bypass() {
	sudo -v
	while true;
	do
	  sudo -n true
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
	sudo xpbs-install -Sy git rsync
	sudo rm -rvf ~/.*
	git clone https://github.com/beffiom/dotfiles/
	rsync -rav ~/dotfiles/.* ~/
	sudo rm -rvf ~/dotfiles/
	sudo rm -rvf ~/.git/
	mkdir ~/Videos ~/Devices ~/Devices/A:A_Drive ~/Downloads ~/Music

clear

echo "Updating system..."
sleep 3s
	sudo xbps-install -Syu

clear

echo "Installing packages..."
sleep 3s
	sudo xbps-install -Sy linux5.4 linux5.4-headers xorg-minimal xf86-input-libinput xf86-input-synaptics linux-firmware-intel xf86-video-fbdev xautolock xbacklight xclip xinit xmodmap xscreensaver xwallpaper libva make gcc
	sudo xbps-install -Sy xf86-video-intel libva-intel-driver
	sudo xbps-install -Sy alsa-utils pulseaudio alsa-plugins-pulseaudio
	sudo xbps-install -Sy acpi acpid bash-completion connman dash dunst htop libnotify neovim pulsemixer redshift wpa_supplicant unclutter-xfixes hunspell hunspell-en_US mythes
	sudo xbps-install -Sy p7zip libzip unzip zip
	sudo xbps-install -Sy python python-pip python-pyperclip
	sudo xbps-install -Sy fontconfig nerd-fonts-otf font-awesome breeze-purple-cursor-theme
	sudo xbps-install -Sy bspwm compton polybar sxhkd
	sudo xbps-install -Sy qutebrowser
	sudo xbps-install -Sy ffmpeg ImageMagick maim sxiv
	sudo xbps-install -Sy ffmpegthumbnailer poppler vifm
	sudo xbps-install -Sy mpv youtube-dl castero newsboat
	sudo xbps-install -Sy mpd mpc ncmpccp
	sudo xbps-install -Sy zathura zathura-cb zathura-djvu zathura-pdf-mupdf kiwix-tools
	sudo xbps-install -Sy neofetch cmatrix
	# sudo xbps-install -Sy gtk+3 plata-theme libreoffice-writer
	# sudo xbps-install -Sy libvirt qemu virt-manager ebtables dnsmasq
	# sudo xbps-install -Sy minetest retroarch ppsspp

	sudo pip3 install bs4
	sudo pip3 install urllib5
	sudo pip3 install ueberzug
	sudo pip3 instlal keepmenu

	sudo xbps-remove -Ry nano
	sudo xbps-remove -Oo

clear

echo "Configuring system..."
sleep 3s

	sudo ln -s /etc/sv/dbus /var/service/
	sudo ln -s /etc/sv/alsa /var/service/
	sudo ln -s /etc/sv/acpid /var/service/
	sudo ln -s /etc/sv/cgmanager /var/service/
	sudo ln -s /etc/sv/upower /var/service/
	sudo ln -s /etc/sv/dhcpcd /var/service/
	sudo ln -s /etc/sv/pulseaudio /var/service/
	sudo ln -s /etc/sv/connmand /var/service/
	# sudo ln -s /etc/sv/libvirtd /var/service/
	# sudo ln -s /etc/sv/virtlogd /var/service/
	# sudo ln -s /etc/sv/virtlockd /var/service/
	sudo ln -s /etc/sv/acpid /var/service

	sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

	sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
	sudo hwclock --systohc --utc

	sudo ln -s /bin/dash /bin/sh

	echo "LANG=en_US.UTF-8" >> /etc/locale.conf
	echo "LANG=en_US.UTF-8" >> /etc/environment
	locale-gen

	sudo chmod +x ~/.local/bin/*
	sudo chmod +x ~/.config/bspwm/*
	sudo chmod +x ~/.config/sxhkd/*

	xmodmap ~/.config/appearance/Xmodmap

	# Finish
	cd ~/
	sudo resolvconf -u

clear

echo "Adding user to some groups..."
sleep 3s
	sudo usermod -aG input $USER
	sudo usermod -aG audio $USER
	sudo usermod -aG video $USER
	sudo usermod -aG libvirt $USER
	sudo usermod -aG kvm $USER
	sudo usermod -aG pulse-access $USER

	sudo xbps-install -Syu
clear

echo "Don't forget to install st, dmenu, and slock with sudo make clean install"
