# test -z "$TMUX"; and exec tmux
if status is-interactive
    # Commands to run in interactive sessions can go here
end
export GPG_TTY=(tty)

# aliases
alias vim=nvim
alias vi=nvim
alias pg='ping www.google.com'
alias gl='git log --oneline --graph --all --decorate'
alias gc='git checkout'
alias gp='git pull'
alias yt="yt-dlp "
alias ytb="yt-dlp -f 'bv+ba/b' "
alias yta="yt-dlp -f 'ba' -S 'ext' "

# add bunch of fish functions
source ~/.config/fish/functions/fish_functions.fish

eval (direnv hook fish)

test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

set -x LC_ALL en_US.UTF-8


# On macOS, the default number of file descriptors is far too low ('256').
# That would cause Docker to run out of available file handles, so let's
# bump it up.
ulimit -n 2048

# Some operations with 'docker-compose' can take awhile without output
# (such as running tests). 'docker-compose' has a default timeout of
# 60 seconds, which is too little. Bump it up (in seconds) to 5 minutes.
set -x COMPOSE_HTTP_TIMEOUT 300

# Bun
set -Ux BUN_INSTALL "/Users/akash/.bun"
set -px --path PATH "/Users/akash/.bun/bin" "/Users/akash/.local/bin"

