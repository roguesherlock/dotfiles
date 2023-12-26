#!/bin/sh

mkdir ~/Developer

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

git clone https://github.com/roguesherlock/dotfiles.git ~/Developer/dotfiles

#fish
mkdir -p ~/.config/fish/
ln -sF ~/Developer/dotfiles/.config/fish ~/.config/fish

# tmux
ln -sf ~/Developer/dotfiles/.tmux.conf ~/.tmux.conf

# vimrc
ln -sf ~/Developer/dotfiles/.vimrc ~/.vimrc

# ssh
mkdir -p ~/.ssh
ln -sf ~/Developer/dotfiles/.ssh/config ~/.ssh/config

# gnupg
mkdir -p ~/.gnupg
ln -sf ~/Developer/dotfiles/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
ln -sf ~/Developer/dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf

# git
ln -sf ~/Developer/dotfiles/.gitconfig ~/.gitconfig

# alacritty
mkdir -p ~/.config/alacritty/
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
mkdir -p ~/Library/Application\ Support/lazygit
ln -sF ~/Developer/dotfiles/.config/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml

# rtx
mkdir -p ~/.config/rtx/
ln -sF ~/Developer/dotfiles/.config/rtx/config.toml ~/.config/rtx/config.toml

# startship prompt
ln -sF ~/Developer/dotfiles/.config/starship.toml ~/.config/starship.toml
