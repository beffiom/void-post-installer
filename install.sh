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
	git clone https://github.com/beffiom/linux-dotfiles/
	rsync -rav ~/linux-dotfiles/.* ~/
	sudo rm -rvf ~/linux-dotfiles/
	sudo rm -rvf ~/.git/
	mkdir ~/Videos ~/Devices ~/Devices/A:A_Drive ~/Downloads ~/Music

clear

echo "Updating system..."
sleep 3s
	sudo xbps-install -Syu

clear

echo "Installing packages..."
sleep 3s
	sudo xbps-install -Sy linux-headers xorg-minimal xf86-input-libinput xf86-input-synaptics xf86-video-fbdev xautolocok xbacklight xclip xinit xmodmap xscreensaver xwallpaper libva
	sudo xbps-install -Sy xf86-video-intel libva-intel-driver intel-ucode
	sudo xbps-install -Sy alsa-utils pulseaudio alsa-plugins-pulseaudio
	sudo xbps-install -Sy acpi acpid bash-completion connman dunst htop libnotify neovim pulsemixer redshit wpa_supplicant unclutter-xfixes
	sudo xbps-install -Sy p7zip libzip unzip zip
	sudo xbps-install -Sy python python-pip python-pyperclip
	sudo xbps-install -Sy fontconfig font-inconsolata-otf font-libertine-otf fonts-droid-ttf font-awesome breeze-purple-cursor-theme
	sudo xbps-install -Sy bspwm compton polybar sxhkd
	sudo xbps-install -Sy firefox
	sudo xbps-install -Sy ffmpeg ImageMagick maim sxiv
	sudo xbps-install -Sy ffmpegthumbnailer poppler vifm
	sudo xbps-install -Sy mpv youtube-dl
	sudo xbps-install -Sy zathura zathura-cb zathura-djvu zathura-pdf-mupdf

	sudo pip install bs4
	sudo pip install urllib5
	sudo pip install ueberzug
	sudo pip instlal keepmenu

	#install st
	cd ~/.config/st
	sudo make clean install

	#install dmenu
	cd ~/.config/dmenu
	sudo make clean install

	#install slock
	cd ~/.config/slock
	sudo make cleak install

	sudo xbps-remove -Ry nano
	sudo xbps-remove -oy
	sudo xbps-remove -O

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

	sudo mv -v ~/.config/appearance/fonts/* /usr/share/fonts/truetype/
	sudo rm -rvf ~/.config/appearance/fonts/
	sudo fc-cache -f -v

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
	# sudo usermod -aG libvirt $USER
	# sudo usermod -aG kvm $USER
	sudo usermod -aG pulse-access $USER

	sudo xbps-install -Syu

clear
