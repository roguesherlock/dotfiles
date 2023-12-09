if status is-interactive
    # test -z "$TMUX"; and exec tmux
    # Commands to run in interactive sessions can go here

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
    alias g git
    command -qv nvim && alias vim nvim
    if type -q kitty
        alias icat="kitty +kitten icat"
        alias s="kitty +kitten ssh"
    end
    if type -q exa
        alias ls "exa --icons --classify"
        alias ll "exa --icons --header --long --git --classify"
        alias tree "exa --icons --header --long --tree --level=3"
        alias lla "ll --all"
    end

    set -gx EDITOR nvim

    # add bunch of fish functions
    source ~/.config/fish/functions/fish_functions.fish

    # successor to nvm
    set -gx FNM_LOGLEVEL quiet
    fnm env --use-on-cd --resolve-engines | source

    direnv hook fish | source
    rtx activate fish | source

    # Setting PATH for Python 3.12
    # The original version is saved in /Users/akash/.config/fish/config.fish.pysave
    set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

    if test "$TERM_PROGRAM" != WarpTerminal
        test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
    end

    # themes
    # source ~/.config/fish/themes/terafox.fish

    # New Hey
    # alias new_hey 'touch ~/Developer/aaakash.xyz/src/content/heys/(date -I).md && echo ---\ndate:\ (date -I)\n--- > ~/Developer/aaakash.xyz/src/content/heys/(date +"%Y-%m-%d").md'
    function new_hey
        if test -z $argv[1]
            set date (date -I)
        else
            set date $argv[1]
        end
        set filename "$date.md"
        set filepath "$HOME/Developer/aaakash.xyz/src/content/heys/$filename"
        if test -f $filepath
            echo "File $filepath already exists"
            return
        end
        touch $filepath # Create file with default value if empty
        echo ---\ndate: $date\n--- >$filepath # Add frontmatter
        echo "File $filepath created" # Print message
    end
end
export GPG_TTY=(tty)

set -x LC_ALL en_US.UTF-8

# On macOS, the default number of file descriptors is far too low ('256').
# That would cause Docker to run out of available file handles, so let's
# bump it up.
ulimit -n 2048

# Some operations with 'docker-compose' can take awhile without output
# (such as running tests). 'docker-compose' has a default timeout of
# 60 seconds, which is too little. Bump it up (in seconds) to 5 minutes.
set -x COMPOSE_HTTP_TIMEOUT 300
