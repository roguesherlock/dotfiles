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
		alias ls "ls -p -G"
		alias la "ls -A"
		alias ll "ls -l"
		alias lla "ll -A"
		alias g git
		command -qv nvim && alias vim nvim
		if type -q exa
			alias ll "exa -l -g --icons"
			alias lla "ll -a"
		end

		set -gx EDITOR nvim

    # add bunch of fish functions
    source ~/.config/fish/functions/fish_functions.fish

    eval (direnv hook fish)

    test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

    # Bun
    set -Ux BUN_INSTALL "/Users/akash/.bun"
    set -U fish_user_paths "/Users/akash/.bun/bin" "/Users/akash/.local/bin" "/Users/akash/.cargo/bin" $fish_user_paths

		# pyenv
		set -Ux PYENV_ROOT $HOME/.pyenv
		set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

		# poetry
		set -Ux POETRY_HOME $HOME/.poetry
		set -U fish_user_paths $HOME/.poetry/bin $fish_user_paths

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
			echo ---\ndate: $date\n--- > $filepath # Add frontmatter
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

# pyenv
pyenv init - | source

# successor to nvm
set -gx FNM_LOGLEVEL "quiet";
fnm env --use-on-cd | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /Users/akash/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

