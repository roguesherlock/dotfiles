#!/bin/sh
#
# To be used in nixos system to bootstrap the system
#

if [ $# -eq 0 ]; then
	echo "Usage: $0 <machine-name>"
	echo "Please provide the name of the machine you want to install as an argument."
	exit 1
fi

mkdir ~/Developer

# Clone dotfiles
nix-shell -p git --command "git clone https://github.com/roguesherlock/dotfiles ~/Developer/dotfiles"

# Generate hardware config for new system
sudo nixos-generate-config --show-hardware-config > ~/Developer/dotfiles/nixos/machines/hardware-configuration.nix

sudo nixos-rebuild switch --flake ~/Developer/dotfiles#$1
