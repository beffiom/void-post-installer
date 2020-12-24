# void-post-intaller
installs my dotfiles and key programs after a minimal void linux install

## instructions
1. login as root
2. xbps-install -U
3. `xbps-install opendoas neovim`
4. nvim /etc/doas.conf
5. add "permit nopass :wheel"
6. `git clone https://github.com/beffiom/void-post-installer`
7. `cd void-post-installer`
8. `. install.sh`
