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
alias flush_dns='sudo dscacheutil -flushcache; and sudo killall -HUP mDNSResponder'
alias build_augusta='./create_client.py augusta; and docker-compose -f clients-augusta.yml -p augusta build'
alias start_augusta='docker-compose -f clients-augusta.yml -p augusta up -d'
alias stop_augusta='docker-compose -f clients-augusta.yml -p augusta down'
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

set -x LC_ALL en_US.UTF-8


# On macOS, the default number of file descriptors is far too low ('256').
# That would cause Docker to run out of available file handles, so let's
# bump it up.
ulimit -n 2048

# Some operations with 'docker-compose' can take awhile without output
# (such as running tests). 'docker-compose' has a default timeout of
# 60 seconds, which is too little. Bump it up (in seconds) to 5 minutes.
set -x COMPOSE_HTTP_TIMEOUT 300

# Since 'docker-compose' will now be working across multiple repositories,
# we'll export a ENV variable that it can read to figure out where all our
# repos are checked out at.
set -x REPO_DIR ~/Developer
