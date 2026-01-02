#!/usr/bin/env bash

if [[ "$#" -eq 0 ]]; then
  echo "Error: No argument provided"
  echo "Usage: $0 <path_to_img>"
  exit 1
fi

path="$1"
repo="https://github.com/noid-linux/xbps-repo/releases/latest/download"
pkgs="neovim alacritty starship brave gruvbox-material-theme gruvbox-bibata-cursor-theme nerd-fonts-cascadiacode ndpm flatpak gparted noid-welcome calamares"

yes | ./mkiso.sh -a x86_64 -b xfce \
	-r "$repo" -- -p "$pkgs" -I noid \
	-C "live.autologin" -T "Noid Linux" \
	-v "linux-lts" -o "$path"
