#!/bin/sh

mkdir ~/Developer

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone https://github.com/roguesherlock/dotfiles.git ~/Developer/dotfiles

# tmux
ln -sf ~/Developer/dotfiles/.tmux.conf ~/.tmux.conf

# vimrc
ln -sf ~/Developer/dotfiles/.vimrc ~/.vimrc

mkdir .ssh
# ssh
ln -sf ~/Developer/dotfiles/.ssh/config ~/.ssh/config

mkdir .gnupg
# gnupg
ln -sf ~/Developer/dotfiles/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
ln -sf ~/Developer/dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf

# git
ln -sf ~/Developer/dotfiles/.gitconfig ~/.gitconfig

# alacritty
mkdir ~/.config/alacritty/ -p
ln -sF ~/Developer/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

#karabinner
mkdir ~/.config/karabiner/
ln -sF ~/Developer/dotfiles/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

#nvim
ln -sF ~/Developer/dotfiles/.config/nvim ~/.config/nvim
