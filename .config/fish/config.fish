set -l os_type (uname -s)

if string match -q Linux $os_type
    set -g isLinux 1
else
    set -g isLinux 0
end

if string match -q Darwin $os_type
    set -g isDarwin 1
else
    set -g isDarwin 0
end

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
    # source ~/.config/fish/functions/fish_functions.fish

    # themes
    # source ~/.config/fish/themes/terafox.fish

    set fish_greeting "I solemnly swear that I am up to no good."

    # New Hey
    # alias new_hey 'touch ~/Developer/aaakash.xyz/src/content/heys/(date -I).md && echo ---\ndate:\ (date -I)\n--- > ~/Developer/aaakash.xyz/src/content/heys/(date +"%Y-%m-%d").md'
    function new_hey
        if test -z $argv[1]
            set date (date -I)
        else
            set date $argv[1]
        end
        set filename "$date.md"
        set filepath "$HOME/Developer/akashpomal-com/src/content/heys/$filename"
        if test -f $filepath
            echo "File $filepath already exists"
            return
        end
        touch $filepath # Create file with default value if empty
        echo ---\ndate: $date\n--- >$filepath # Add frontmatter
        echo "File $filepath created" # Print message
    end
    if type starship >/dev/null 2>&1
        starship init fish | source
    end

    if test $isDarwin -eq 1
        # successor to nvm
        set -gx FNM_LOGLEVEL quiet
        fnm env --use-on-cd --resolve-engines | source

        direnv hook fish | source
        mise activate fish | source

        # Setting PATH for Python 3.12
        # The original version is saved in /Users/akash/.config/fish/config.fish.pysave
        # set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

        if test "$TERM_PROGRAM" != WarpTerminal
            test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
        end
    end

    if test $isLinux -eq 1
        function nixbuild
            sudo nixos-rebuild switch --flake ~/Developer/dotfiles
        end

        function nixtest
            sudo nixos-rebuild test --flake ~/Developer/dotfiles
        end
    end
end
export GPG_TTY=(tty)

set -x LC_ALL en_US.UTF-8

if test $isDarwin -eq 1
    # On macOS, the default number of file descriptors is far too low ('256').
    # That would cause Docker to run out of available file handles, so let's
    # bump it up.
    ulimit -n 2048
    # Some operations with 'docker-compose' can take awhile without output
    # (such as running tests). 'docker-compose' has a default timeout of
    # 60 seconds, which is too little. Bump it up (in seconds) to 5 minutes.
    set -x COMPOSE_HTTP_TIMEOUT 300

    # bun
    set --export BUN_INSTALL "$HOME/.bun"
    set --export PATH $BUN_INSTALL/bin $PATH
end
