#!/bin/bash

set -e

function install_yaourt() {
	last_pwd=$(pwd)
	cd /tmp
	rm -rf /tmp/yaourt-installation
	mkdir yaourt-installation
	cd yaourt-installation
	git clone https://aur.archlinux.org/package-query.git
	git clone https://aur.archlinux.org/yaourt.git
	cd package-query
	makepkg -si --noconfirm --needed
	cd ../yaourt
	makepkg -si --noconfirm --needed
	cd "$last_pwd"
	rm -rf /tmp/yaourt-installation
}

su -c 'echo "Server=https://mirrors.kernel.org/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist'

# TODO: Open up the multilib

su -c 'pacman -S --no-confirm --needed sudo base-devel pacman-contrib'

if ! [ -x hash yaourt ]; then
	install_yaourt
fi

# Update mirror list
curl -s 'https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4' | \
	sed -i 's/^#Server/Server/' |\
	rankmirrors -n 8 - |\
	sudo tee -a /etc/pacman.d/mirrorlist >/dev/null

yaourt -Syua --noconfirm

yaourt -S --noconfirm --needed $(<./packages)
