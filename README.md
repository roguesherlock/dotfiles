# dotfiles
My dotfiles for vim, zsh, tmux, etc.

### Installation
```
cd ~
git clone https://github.com/0xelectron/dotfiles
dotfiles/install
```
* Install zsh
    pacman -S zsh

* [Vim-Plug](https://github.com/junegunn/vim-plug) setup.
    Launch vim and run :PlugInstall

* Finish [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) setup.
   ```
   $ pacman -S cmake
   $ cd ~/.vim/plugged/YouCompleteMe
   $ ./install.py --all
   ```


