#!/bin/sh

mkdir ~/Developer

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone https://github.com/roguesherlock/dotfiles.git ~/Developer/dotfiles

#fish
mkdir ~/.config/fish/ -p
ln -sF ~/Developer/dotfiles/.config/fish/themes ~/.config/fish/themes
ln -sF ~/Developer/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -sF ~/Developer/dotfiles/.config/fish/fish_plugins ~/.config/fish/fish_plugins

# tmux
ln -sf ~/Developer/dotfiles/.tmux.conf ~/.tmux.conf

# vimrc
ln -sf ~/Developer/dotfiles/.vimrc ~/.vimrc

# ssh
mkdir .ssh
ln -sf ~/Developer/dotfiles/.ssh/config ~/.ssh/config

# gnupg
mkdir .gnupg
ln -sf ~/Developer/dotfiles/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
ln -sf ~/Developer/dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf

# git
ln -sf ~/Developer/dotfiles/.gitconfig ~/.gitconfig

# alacritty
mkdir ~/.config/alacritty/ -p
ln -sF ~/Developer/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

#karabinner
ln -sF ~/Developer/dotfiles/.config/karabiner ~/.config/karabiner

#nvim
ln -sF ~/Developer/dotfiles/.config/nvim ~/.config/nvim

#wezterm
ln -sF ~/Developer/dotfiles/.config/wezterm ~/.config/wezterm

#kitty
ln -sF ~/Developer/dotfiles/.config/kitty ~/.config/kitty

#lazygit
ln -sF ~/Developer/dotfiles/.config/lazygit ~/.config/lazygit
ln -sF ~/Developer/dotfiles/.config/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml
