#
# Fish Configs
#
# Created by 0xelectron
#

# Pyenv Setup
set -x PATH "/home/electron/.pyenv/bin" $PATH
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)

# Pywal
# Import colorscheme from 'wal'
# wal -r &

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

# Start Tmux
test $TERM != "screen"; and exec tmux
