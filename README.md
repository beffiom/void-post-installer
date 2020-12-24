# void-post-intaller
installs my dotfiles and key programs after a minimal void linux install

## instructions
1. login as root
2. xbps-install -Su
3. `xbps-install opendoas neovim`
4. nvim /etc/doas.conf
5. add "permit nopass :wheel"
6. exit
7. login user
8. doas xbps-install git
9. `git clone https://github.com/beffiom/void-post-installer`
10. `cd void-post-installer`
11. `. install.sh`

#installing picom
https://github.com/ibhagwan/picom-ibhagwan-template
