#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Usage: $0 <machine-name>"
    echo "Please provide the name of the machine you want to install as an argument.
    exit 1
fi

mkdir ~/Developer

# Clone dotfiles
nix-shell -p git --command "git clone https://github.com/roguesherlock/dotfiles ~/Developer/dotfiles"

# Generate hardware config for new system
sudo nixos-generate-config --show-hardware-config >~/dotfiles/nixos/machines/hardware-configuration.nix

sudo nixos-rebuild switch --flake ~/dotfiles#$1;

