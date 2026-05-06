#!/usr/bin/env bash

if [[ "$#" -lt 2 ]]; then
  echo "Error: No argument provided"
  echo "Usage: $0 <desktop_environment> <path_to_img>"
  exit 1
fi

de="$1"
path="$2"
repo="https://github.com/noid-linux/xbps-repo/releases/latest/download"
pkgs="neovim alacritty starship brave ndpm flatpak gparted noid-welcome calamares bazaar git"
xfce_pkgs="$pkgs gruvbox-material-theme gruvbox-bibata-cursor-theme nerd-fonts-cascadiacode"

case $de in
	"base-dinit")
		./mkiso.sh -a x86_64 -b "base" -i "dinit" \
			-r "$repo" -- -C "live.autologin" -T "Noid Linux" \
			-v "linux-mainline" -o "$path"
		;;
	"xfce-dinit")
		./mkiso.sh -a x86_64 -b "xfce" -i "dinit" \
			-r "$repo" -- -p "$xfce_pkgs" -I iso-profiles/common/ -I iso-profiles/xfce/ \
			-C "live.autologin" -T "Noid Linux" \
			-v "linux-lts" -o "$path"
		;;
	"xfce")
		yes | ./mkiso.sh -a x86_64 -b "xfce" \
			-r "$repo" -- -p "$xfce_pkgs" -I iso-profiles/common/ -I iso-profiles/xfce/ \
			-C "live.autologin" -T "Noid Linux" \
			-v "linux-lts" -o "$path"
		;;
	"kde"|"gnome")
		yes | ./mkiso.sh -a x86_64 -b "$de" \
			-r "$repo" -- -p "$pkgs" -I iso-profiles/common/ -I iso-profiles/"$de"/ \
			-C "live.autologin" -T "Noid Linux" \
			-v "linux-lts" -o "$path"
		;;
	*)
		echo "Error: Unknown desktop environment '$de'"
		echo "Supported: xfce, kde, gnome"
		exit 1
		;;
esac
