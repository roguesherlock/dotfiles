# test -z "$TMUX"; and exec tmux

# aliases
alias vim=nvim
alias vi=nvim
alias pg='ping www.google.com'
alias gl='git log --oneline --graph --all --decorate'
alias gc='git checkout'
alias gp='git pull'
alias afk='fish ~/Developer/dotfiles/scripts/slack_presence/afk.fish'
alias back='fish ~/Developer/dotfiles/scripts/slack_presence/back.fish'
# fetch word definition from vocabulary.com.
# uses vcbl by @rahilwazir. To install, do
# go get github.com/atomicnumber1/vcbl
alias wtfis='vcbl --desc both'

# add go binaries to path
set PATH /Users/akash/go/bin/ $PATH

# add bunch of fish functions
source ~/.config/fish/functions/fish_functions.fish

eval (direnv hook fish)


test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths

export LC_ALL=en_US.UTF-8
