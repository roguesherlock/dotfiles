$env.EDITOR = "nvim"
$env.VISUAL = "nvim"


$env.PROMPT_INDICATOR_VI_INSERT = ''

# secrets
source ~/.env.nu

# PATH
$env.PATH = (
  $env.PATH
  | split row (char esep)
  | append /usr/local/bin
  | append `/Users/akash/Library/Application Support/Herd/bin`
  | append ($env.HOME | path join .local bin)
  | append ($env.HOME | path join .sst bin)
  | append ($env.HOME | path join .cargo bin)
  | append ($env.HOME | path join .bun bin)
  | append ($env.HOME | path join go bin)
  | uniq # filter so the paths are unique
  | prepend '/opt/homebrew/bin'
)

# aliases
# apparently kitty isn't loaded in zellij shell so we alias it here
alias kitty = /Applications/kitty.app/Contents/MacOS/kitty
alias top = btop
alias nopen = open
alias open = ^open
alias vi = nvim
alias ytb = yt-dlp -f 'bv+ba/b' 
alias yta = yt-dlp -f 'ba' -S 'ext' 
alias icat = kitty +kitten icat
alias s = kitty +kitten ssh
alias tree = eza --icons --header --long --tree --level=3
alias ll = ls -la

$env.config.show_banner = false
# TODO: c-f completion doesn't work with vi mode
# $env.config.edit_mode = "vi"

# empty hooks to avoid errors. mise and others add their own hooks.
$env.config.hooks = {
    pre_prompt: [{ null }] # run before the prompt is shown
    pre_execution: [{ null }] # run before the repl input is run
    env_change: {
        PWD: [{|before, after| null }] # run if the PWD environment is different since the last repl input
    }
    display_output: "if (term size).columns >= 100 { table -e } else { table }" # run to display the output of a pipeline
    command_not_found: { null } # return an error message when a command is not found
}

# mise
# mkdir ~/.local/share/mise/
# mise activate nu | save -f ~/.local/share/mise/init.nu
use ~/.local/share/mise/init.nu


# direnv
# $env.config.hooks.env_change.PWD = { ||
#     if (which direnv | is-empty) {
#         return
#     }
#
#     direnv export json | from json | default {} | load-env
# }


# zoxide
# mkdir ~/.local/share/zoxide/
# zoxide init nushell | save -f ~/.local/share/zoxide/init.nu
source ~/.local/share/zoxide/init.nu


# atuin
# mkdir ~/.local/share/atuin/
# atuin init nu | save ~/.local/share/atuin/init.nu
source ~/.local/share/atuin/init.nu


# carspace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
# mkdir ~/.local/share/carapace
# carapace _carapace nushell | save --force ~/.local/share/carapace/init.nu
source ~/.local/share/carapace/init.nu


# starship
$env.STARSHIP_SHELL = "nu"
# mkdir ~/.local/share/starship/
# starship init nu | save -f ~/.local/share/starship/init.nu
use ~/.local/share/starship/init.nu

