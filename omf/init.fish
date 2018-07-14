test -z "$TMUX"; and exec tmux
set -gx EDITOR "nvim"

# aliases
alias vi='nvim'
alias vim='nvim'
alias pg='ping www.google.com'

# take care of some things on login
if status is-login
    if test -n "$DISPLAY"
        # Enable Natural Scrolling
        xinput --set-prop 8 'libinput Natural Scrolling Enabled' 1

        # Disable caps lock
        # setxkbmap -option caps:none > /dev/null 2>&1

        # mount google drive if not mounted already
        # mount | grep "$HOME/Google Drive" > /dev/null 2>&1; or /usr/bin/google-drive-ocamlfuse "$HOME/Google Drive" 2>&1
    end
end
