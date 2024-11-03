$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

$env.config.show_banner = false


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
alias top = btop
alias nu-open = open
alias open = ^open
alias vi = nvim
alias ytb = yt-dlp -f 'bv+ba/b' 
alias yta = yt-dlp -f 'ba' -S 'ext' 
alias icat = kitty +kitten icat
alias s = kitty +kitten ssh
alias tree = eza --icons --header --long --tree --level=3
alias ll = ls

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

# starship
$env.STARSHIP_SHELL = "nu"
# starship init nu | save -f ~/.cache/starship/init.nu
use ~/.cache/starship/init.nu

# mise
# mise activate nu | save -f ~/.cache/mise/init.nu
use ~/.cache/mise/init.nu

# direnv
# $env.config.hooks.env_change.PWD = { ||
#     if (which direnv | is-empty) {
#         return
#     }
#
#     direnv export json | from json | default {} | load-env
# }

# secrets
source ~/.env.nu
