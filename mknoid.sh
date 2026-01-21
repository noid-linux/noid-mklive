#!/usr/bin/env bash

if [[ "$#" -eq 0 ]]; then
  echo "Error: No argument provided"
  echo "Usage: $0 <desktop_environment> <path_to_img>"
  exit 1
fi

de="$1"
path="$2"
repo="https://github.com/noid-linux/xbps-repo/releases/latest/download"
pkgs="neovim alacritty starship brave ndpm flatpak gparted noid-welcome calamares bazaar"
xfce_pkgs="$pkgs gruvbox-material-theme gruvbox-bibata-cursor-theme nerd-fonts-cascadiacode"

yes | ./mkiso.sh -a x86_64 -b "$de" \
	-r "$repo" -- -p "$pkgs" -I noid/"$de" \
	-C "live.autologin" -T "Noid Linux" \
	-v "linux-lts" -o "$path"

case $de in
	"xfce")
		yes | ./mkiso.sh -a x86_64 -b "xfce" \
						 -r "$repo" -- -p "$xfce_pkgs" -I noid/xfce \
						 -C "live.autologin" -T "Noid Linux" \
						 -v "linux-lts" -o "$path"
			;;
	"kde")
		yes | ./mkiso.sh -a x86_64 -b "kde" \
						 -r "$repo" -- -p "$pkgs" -I noid/kde \
						 -C "live.autologin" -T "Noid Linux" \
						 -v "linux-lts" -o "$path"
			;;
	"gnome")
		yes | ./mkiso.sh -a x86_64 -b "gnome" \
						 -r "$repo" -- -p "$pkgs" -I noid/gnome \
						 -C "live.autologin" -T "Noid Linux" \
						 -v "linux-lts" -o "$path"
			;;
esac
