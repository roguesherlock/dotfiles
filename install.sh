#!/bin/sh

mkdir ~/Developer

OS=$(uname -s)
DOTFILES_DIR=~/Developer/dotfiles
FORCE=false

# Parse named command-line arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
	--force) FORCE=true ;;
	*) break ;;
	esac
	shift
done

isDarwin() {
	[ "$OS" = "Darwin" ]
}

isLinux() {
	[ "$OS" = "Linux" ]
}

install() {
	local TARGET_PATH="$1"
	local LINK_PATH="$2"

	if [ "$FORCE" = "true" ]; then
		# Create the symbolic link
		ln -sf "$TARGET_PATH" "$LINK_PATH"
		echo "Symbolic link forcefully created at $LINK_PATH -> $TARGET_PATH"

		# Check if the symlink or file already exists at the destination
	elif [ -e "$LINK_PATH" ] || [ -L "$LINK_PATH" ]; then
		echo "[warn] A file or symbolic link already exists at $LINK_PATH. No action taken."
	else
		# Create the symbolic link
		ln -s "$TARGET_PATH" "$LINK_PATH"
		echo "Symbolic link created at $LINK_PATH -> $TARGET_PATH"
	fi
}

if isDarwin; then
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
fi

if [ -d "$DOTFILES_DIR" ]; then
	echo "[warn] Looks like dotfiles already exists. Not cloning again."
else
	git clone https://github.com/roguesherlock/dotfiles.git $DOTFILES_DIR
  echo "Dotfiles cloned to $DOTFILES_DIR"
fi

mkdir -p ~/.config

#fish
# mkdir -p ~/.config/fish/
install ~/Developer/dotfiles/.config/fish ~/.config/fish

# tmux
install ~/Developer/dotfiles/.tmux.conf ~/.tmux.conf

# vimrc
install ~/Developer/dotfiles/.vimrc ~/.vimrc

# ssh
mkdir -p ~/.ssh
install ~/Developer/dotfiles/.ssh/config ~/.ssh/config

# gnupg
mkdir -p ~/.gnupg
install ~/Developer/dotfiles/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
install ~/Developer/dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf

# git
if isDarwin; then
  install ~/Developer/dotfiles/.gitconfig ~/.gitconfig
elif isLinux; then
  install ~/Developer/dotfiles/.gitconfig-linux ~/.gitconfig
fi

# alacritty
mkdir -p ~/.config/alacritty/
install ~/Developer/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

if isDarwin; then
	#karabinner
	install ~/Developer/dotfiles/.config/karabiner ~/.config/karabiner
fi

#nvim
install ~/Developer/dotfiles/.config/nvim ~/.config/nvim

#wezterm
install ~/Developer/dotfiles/.config/wezterm ~/.config/wezterm

#kitty
install ~/Developer/dotfiles/.config/kitty ~/.config/kitty

#lazygit
install ~/Developer/dotfiles/.config/lazygit ~/.config/lazygit
if isDarwin; then
	mkdir -p ~/Library/Application\ Support/lazygit
	install ~/Developer/dotfiles/.config/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml
fi

# mise
# mkdir -p ~/.config/mise/
install ~/Developer/dotfiles/.config/mise ~/.config/mise

# startship prompt
install ~/Developer/dotfiles/.config/starship.toml ~/.config/starship.toml
