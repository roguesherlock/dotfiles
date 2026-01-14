set -l os_type (uname -s)
export GPG_TTY=(tty)

function __fish_update_zellij_tabname_prompt --on-event fish_prompt
    if set -q ZELLIJ
        zellij action rename-tab "fish $(prompt_pwd)"
    end
end

function __fish_update_zellij_tabname_preexec --on-event fish_preexec
    if set -q ZELLIJ
        # zellij action rename-tab "$argv"
        set cmd "$(string split " " $argv[1])"
        zellij action rename-tab "$cmd $(prompt_pwd)"
    end
end

if status is-interactive
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
    alias lg lazygit
    alias ls "eza --icons --classify"
    alias ll "eza --icons --header --long --git --classify"
    alias tree "eza --icons --header --long --tree --level=3"
    alias lla "ll --all"

    set -gx EDITOR nvim

    set fish_greeting "I solemnly swear that I am up to no good."

    # successor to nvm
    direnv hook fish | source
    mise activate fish | source
    fzf --fish | source

    #magical shell history
    atuin init fish | source

    if test "$TERM_PROGRAM" != WarpTerminal
        if type starship >/dev/null 2>&1
            starship init fish | source
        end
    end

    if test "$TERM_PROGRAM" = iTerm.app
        test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
    end

end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# opencode
fish_add_path /Users/akash/.opencode/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/akash/.lmstudio/bin
# End of LM Studio CLI section

# ami
set --export AMI_INSTALL "$HOME/.ami"
set --export PATH $AMI_INSTALL/bin $PATH
