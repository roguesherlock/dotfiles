# test -z "$TMUX"; and exec tmux

# aliases
alias vim=nvim
alias vi=nvim
alias pg='ping www.google.com'
alias gl='git log --oneline --graph --all --decorate'
alias gc='git checkout'
alias gp='git pull'
alias afk='fish ~/.sleep'
alias back='fish ~/.wakeup'
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

