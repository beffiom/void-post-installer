# void-post-intaller
installs my dotfiles and key programs after a minimal void linux install

## instructions
1. login as root
2. `xbps-install doas nvim`
3. `nvim /etc/doas.conf`
4. add this line:    permit :wheel nopass
5. save and reboot
6. login user
7. `git clone https://github.com/beffiom/void-post-installer`
8. `cd void-post-installer`
9. `. install.sh`
