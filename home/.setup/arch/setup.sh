#!/bin/bash

function install_yaourt() {
	last_pwd=$(pwd)
	cd /tmp
	mkdir yaourt-installation
	cd yaourt-installation
	git clone https://aur.archlinux.org/package-query.git
	git clone https://aur.archlinux.org/yaourt.git
	cd package-query
	makepkg -si --noconfirm --needed
	cd ../yaourt
	makepkg -si --noconfirm --needed
	cd "$last_pwd"
	rm -rf ./yaourt-install
}

install_yaourt

yaourt -Syua --noconfirm
yaourt -S --noconfirm pacman-contrib

# Update mirror list
curl 'https://www.archlinux.org/mirrorlist/?country=all&protocol=http&protocol=https&ip_version=4&ip_version=6' | \
	sed -i 's/^#Server/Server/' \
	rankmirrors -n 8 - > /etc/pacman.d/mirrorlist


yaourt -S --noconfirm --needed < ./packages
