# void-post-intaller
installs my dotfiles and key programs after a minimal void linux install

## instructions
1. login as root
2. xbps-install -Su
3. `xbps-install opendoas neovim chrony`
4. nvim /etc/doas.conf
5. add "permit nopass :wheel"
6. ln -s /etc/sv/chronyd /var/service/
7. exit
8. login user
9. doas xbps-install git
10. `git clone https://github.com/beffiom/void-post-installer`
11. `cd void-post-installer`
12. `. install.sh`

#installing picom
https://github.com/ibhagwan/picom-ibhagwan-template
