#!/bin/bash
# Void Linux post-install script

echo "Starting Void Linux post-install script..."
sleep 3s

echo "Importing files from server..."
sleep 3s
	doas xbps-install -Sy git rsync xmirror
	doas rm -rvf ~/.* ~/dotfiles-void
	git clone https://github.com/beffiom/dotfiles-void ~/dotfiles-void
	doas rsync -rav ~/dotfiles-void/.* ~/
	doas rm -rvf ~/.git/ ~/Downloads ~/README.md ~/LICENSE
	mkdir -p ~/documents ~/media ~/downloads

echo "Updating system..."
sleep 3s
	sudo xmirror
	doas xbps-install -Syu

echo "Installing packages..."
sleep 3s
	doas xbps-install -Sy \
	    sway wl-clipboard wlroots wayland wayland-protocols swaybg swayidle swaylock wtype xdg-desktop-portal-wlr xorg-server-xwayland slurp grim \
	    libinput seatd elogind \
	    linux-firmware-amd mesa vulkan-loader Vulkan-Tools mesa-demos amdvlk \
	    libva make gcc base-devel pkg-config libva-utils \
	    ntfs-3g btrfs-progs ntp cryptsetup \
	    light brightnessctl redshift \
	    alsa-utils pulseaudio alsa-plugins-pulseaudio wireplumber pulsemixer \
	    bluez bluez-alsa libbluetooth bluetuith \
	    acpi acpid \
	    NetworkManager wpa_supplicant \
	    dunst libnotify inotify-tools \
	    p7zip libzip unzip zip \
	    fontconfig noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf font-awesome5 breeze-purple-cursor-theme breeze-snow-cursor-theme nerd-fonts hunspell hunspell-en_US mythes \
	    foot neovim bash-completion atuin ripgrep bat fd tmux ssh zoxide neofetch cmatrix wget curl httrack htop nushell dash yt-dlp gallery-dl udisks2 recutils tofi rbw tldr fzf \
	    python3 python3-dbus python3-devel python3-pip python3-pyperclip clojure babashka clj-kondo clojure-lsp joker leiningen openjdk-common nodejs \
	    qutebrowser chromium podman podman-compose aardvark-dns emacs \
	    mpv playerctl mpv-mpris ffmpeg \
	    mpd mpc ncmpcpp beets \
	    zathura zathura-cb zathura-djvu zathura-pdf-mupdf \
	    gtk+3 lxappearance Adapta
	doas xbps-remove -Oo
 	curl -sS https://starship.rs/install.sh | sh

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
	doas ln -sf /etc/sv/libvirtd /var/service/
	doas ln -sf /etc/sv/virtlogd /var/service/
	doas ln -sf /etc/sv/virtlockd /var/service/
	doas ln -sf /etc/sv/acpid /var/service
	doas ln -sf /etc/sv/bluetoothd /var/service
	doas ln -sf /etc/sv/ntpd /var/service

	doas mkdir -p /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
 	starship preset nerd-font-symbols -o ~/.config/starship.toml

	doas ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
	doas hwclock --systohc --localtime

	doas ln -s /bin/dash /bin/sh

	doas echo "LANG=en_US.UTF-8" >> /etc/locale.conf
	doas echo "LANG=en_US.UTF-8" >> /etc/environment
	doas xbps-reconfigure glibc-locales

	doas chmod +x ~/.config/userscripts/*

	# Finish
	cd ~/


echo "Adding user to some groups..."
sleep 3s
	doas usermod -aG input $USER
	doas usermod -aG audio $USER
	doas usermod -aG video $USER
	doas usermod -aG wheel $USER
	#doas usermod -aG libvirt $USER
	doas usermod -aG kvm $USER
	doas usermod -aG network $USER
	#doas usermod -aG pulse-access $USER
 	#doas usermod -aG docker $USER


	doas xbps-install -Syu

echo "Setup complete, please reboot."
