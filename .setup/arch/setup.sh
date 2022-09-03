#!/bin/bash

set -e

function install_yay() {
	last_pwd=$(pwd)
	tmpdir=$(mktemp -d)

	git clone https://aur.archlinux.org/yay.git "$tmpdir"
	cd $tmpdir
	makepkg -si
	
	cd "$last_pwd"
	rm -rf "$tmpdir"
}

su -c 'echo "Server=https://mirrors.kernel.org/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist'

# TODO: Open up the multilib

su -c 'pacman -S --no-confirm --needed sudo base-devel pacman-contrib'

if ! [ -x hash yay ]; then
	install_yay
fi

# Update mirror list
curl -s 'https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4' | \
	sed -i 's/^#Server/Server/' |\
	rankmirrors -n 8 - |\
	sudo tee -a /etc/pacman.d/mirrorlist >/dev/null

yay -Syyu --noconfirm

yay -S --noconfirm --needed $(<./packages)
