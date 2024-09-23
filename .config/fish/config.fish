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
export GPG_TTY=(tty)

# set -x LC_ALL en_US.UTF-8

# if test $isDarwin -eq 1
#     # On macOS, the default number of file descriptors is far too low ('256').
#     # That would cause Docker to run out of available file handles, so let's
#     # bump it up.
#     ulimit -n 2048
#     # Some operations with 'docker-compose' can take awhile without output
#     # (such as running tests). 'docker-compose' has a default timeout of
#     # 60 seconds, which is too little. Bump it up (in seconds) to 5 minutes.
#     set -x COMPOSE_HTTP_TIMEOUT 300
#
#     # Since we're using U we only need to call this once. Use this command when installing for the first time
#     set -Ux LC_ALL en_US.UTF-8
#     set -Ux BUN_INSTALL "$HOME/.bun"
#     set -U fish_user_paths $fish_user_paths $BUN_INSTALL/bin
#     set -U fish_user_paths $fish_user_paths /Users/akash/.local/bin
# end

# New Hey
# alias new_hey 'touch ~/Developer/aaakash.xyz/src/content/heys/(date -I).md && echo ---\ndate:\ (date -I)\n--- > ~/Developer/aaakash.xyz/src/content/heys/(date +"%Y-%m-%d").md'
function new_hey
    if test -z $argv[1]
        set date (date -I)
    else
        set date $argv[1]
    end
    set filename "$date.md"
    set filepath "$HOME/Developer/akashpomal.com/src/content/heys/$filename"
    if test -f $filepath
        echo "File $filepath already exists"
        return
    end
    touch $filepath # Create file with default value if empty
    echo ---\ndate: $date\n--- >$filepath # Add frontmatter
    echo "File $filepath created" # Print message
end
function zellij_start
    # zellij setup --generate-auto-start fish
    # The following snippet is meant to be used like this in your fish config:
    #
    # if status is-interactive
    #     # Configure auto-attach/exit to your likings (default is off).
    #     # set ZELLIJ_AUTO_ATTACH true
    #     # set ZELLIJ_AUTO_EXIT true
    #     eval (zellij setup --generate-auto-start fish | string collect)
    # end
    set ZELLIJ_AUTO_ATTACH true # If the zellij session already exists, attach to the default session. (not starting as a new session)
    set ZELLIJ_AUTO_EXIT true # When zellij exits, the shell exits as well.

    if not set -q ZELLIJ
        if test "$ZELLIJ_AUTO_ATTACH" = true
            # Get the list of Zellij sessions, ignoring the first two header lines
            set latest_session (zellij list-sessions -sn | tail -n 1)

            # Check if there are any sessions available
            if test -n "$latest_session"
                # Attach to the most recent session
                zellij attach $latest_session
            else
                # Create a new session if none exists
                zellij attach -c
            end
        else
            zellij
            # zellij -l welcome
        end

        if test "$ZELLIJ_AUTO_EXIT" = true
            kill $fish_pid
        end
    end
end

if status is-interactive
    # test -z "$TMUX"; and exec tmux
    # Commands to run in interactive sessions can go here


    # aliases
    alias vim=nvim
    alias vi=nvim
    alias top=btop
    alias pg='ping www.google.com'
    alias gl='git log --oneline --graph --all --decorate'
    alias gc='git checkout'
    alias gp='git pull'
    alias yt="yt-dlp "
    alias ytb="yt-dlp -f 'bv+ba/b' "
    alias yta="yt-dlp -f 'ba' -S 'ext' "
    alias g git
    # if type -q kitty
    alias icat="kitty +kitten icat"
    alias s="kitty +kitten ssh"
    # end
    # if type -q eza
    alias ls "eza --icons --classify"
    alias ll "eza --icons --header --long --git --classify"
    alias tree "eza --icons --header --long --tree --level=3"
    alias lla "ll --all"
    # end

    set -gx EDITOR nvim

    # add bunch of fish functions
    # source ~/.config/fish/functions/fish_functions.fish

    # themes
    # source ~/.config/fish/themes/terafox.fish

    set fish_greeting "I solemnly swear that I am up to no good."

    if test $isLinux -eq 1
        alias nixbuild="sudo nixos-rebuild switch --flake ~/Developer/dotfiles"
        alias nixtest="sudo nixos-rebuild test --flake ~/Developer/dotfiles"
    end


    # successor to nvm
    set -gx FNM_LOGLEVEL quiet
    fnm env --use-on-cd --resolve-engines | source
    direnv hook fish | source
    mise activate fish | source
    fzf --fish | source

    if test "$TERM_PROGRAM" != WarpTerminal
        if type starship >/dev/null 2>&1
            starship init fish | source
        end
    end

    if test "$TERM_PROGRAM" = iTerm.app
        test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
    end

    if test "$TERM_PROGRAM" = iTerm.app -o "$TERM" = xterm-ghostty -o "$TERM" = xterm-kitty -o "$TERM" = alacritty
        zellij_start
    end
end
