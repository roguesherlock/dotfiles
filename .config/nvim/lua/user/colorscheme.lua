local M = {}

-- colors, look at colors()
M.config = {
  opts = {
    enable_auto_switch = true,
    default_light = false,
    -- if enabled, would also set the theme when toggling the theme rather than just the background
    set_theme_on_auto_switch = true,
  },
  nvim = {
    -- light = "github_light_default",
    -- dark = "github_dark_dimmed",
    -- light = "modus",
    -- dark = "modus",
    light = "flexoki",
    dark = "flexoki",
    -- light = "tokyonight",
    -- dark = "tokyonight",
    -- light = "catppuccin-latte",
    -- dark = "catppuccin-frappe",
    -- light = "default",
    -- dark = "default",
    -- dark = "gruvbox-material",
    -- light = "kanso",
    -- dark = "kanso",
    -- light = "oasis",
    -- dark = "oasis",
  },
  ghostty = {
    light = "Flexoki Light",
    dark = "Flexoki Dark",
    -- light = "Github Light High Contrast",
    -- dark = "Github Dark Dimmed",
    -- dark = "Black Metal",
    -- light = "Everforest Dark Hard",
    -- dark = "Everforest Dark Hard",
    -- light = "Catppuccin Latte",
    -- dark = "Catppuccin Frappe",
    -- light = "kanso-pearl",
    -- dark = "kanso-mist",
  },
  kitty = {
    -- light = "Github Light",
    -- dark = "Github Dark Dimmed",
    light = "Flexoki \\(Light\\)",
    dark = "Flexoki \\(Dark\\)",
    -- light = "Everforest Dark Medium",
    -- dark = "Everforest Dark Hard",
    -- light = "Modus Operandi",
    -- dark = "Modus Vivendi",
    -- light = "Tokyo Night Day",
    -- dark = "Tokyo Night",
    -- light = "Catppuccin-Latte",
    -- dark = "Catppuccin-Frappe",
    -- light = "Kanso Pearl",
    -- dark = "Kanso Mist",
  },
  wezterm = {
    light = "Modus Operandi (Gogh)",
    dark = "Modus Vivendi (Gogh)",
  },
  zellij = {
    light = "modus_operandi",
    dark = "modus_vivendi",
    -- light = "tokyo-night-light",
    -- dark = "tokyo-night",
  },
  delta = {
    light = "catppuccin-latte",
    dark = "catppuccin-frappe",
  },
  yazi = {
    light = "catppuccin-latte",
    dark = "catppuccin-frappe",
  },
}

function M.os_is_dark()
  return vim.fn.system([[defaults read -g AppleInterfaceStyle 2>/dev/null]]):find("Dark") and true or false
end

---@param light boolean
function M.set_colorscheme(light)
  local background = light and "light" or "dark"
  local colorscheme = light and M.config.nvim.light or M.config.nvim.dark

  vim.opt.background = background
  if M.config.opts.set_theme_on_auto_switch then
    vim.cmd("colorscheme " .. colorscheme)
  end
end

function M.set_from_os()
  if not M.config.opts.enable_auto_switch then
    M.set_colorscheme(M.config.opts.default_light)
  else
    M.set_colorscheme(not M.os_is_dark())
  end
end

function M.get_colorscheme()
  if not M.config.opts.enable_auto_switch then
    return M.config.opts.default_light and M.config.nvim.light or M.config.nvim.dark
  end
  return M.os_is_dark() and M.config.nvim.dark or M.config.nvim.light
end

function M.setup(config)
  -- Validate config is a table
  -- vim.validate({ config = { config, "table", true } })
  vim.validate("config", config, "table")

  -- Merge user config with defaults
  M.config = vim.tbl_deep_extend("force", vim.deepcopy(M.config), config or {})

  local group = vim.api.nvim_create_augroup("user-colorscheme", { clear = true })
  -- Set initial theme
  M.set_from_os()
  M.setup_termbg_sync(group)

  -- Create autocommands
  vim.api.nvim_create_autocmd("Signal", {
    pattern = "*",
    group = group,
    callback = function()
      vim.schedule(function()
        M.set_from_os()
        -- Force UI refresh
        vim.cmd("redrawstatus!")
        -- Optional: force complete redraw if needed
        -- vim.cmd("redraw!")
      end)
    end,
  })

  vim.api.nvim_create_user_command("Light", function()
    M.set_colorscheme(true)
  end, {})
  vim.api.nvim_create_user_command("Dark", function()
    M.set_colorscheme(false)
  end, {})
end

function M.set_ghostty_theme(theme)
  local config_path = vim.fn.expand("~/.config/ghostty/config")
  local real_path = vim.fn.resolve(config_path)
  local cmd = ""
  if type(theme) == "string" then
    cmd = string.format("sed -i'.bak' 's/^[ ]*theme[ ]*=.*$/theme = %s/' %s", theme, real_path)
  else
    local light_dark_theme = string.format("light:%s,dark:%s", theme.light, theme.dark)
    cmd = string.format("sed -i'.bak' 's/^[ ]*theme[ ]*=.*$/theme = %s/' %s", light_dark_theme, real_path)
  end

  local result = vim.fn.system({ "bash", "-c", cmd })
  -- Get Ghostty PID(s) from system command
  local output = vim.fn.system("ps -axo pid=,args= | grep -i ghostty | grep -v grep")

  -- Extract PIDs (one or more)
  local pids = {}
  for pid in output:gmatch("(%d+)") do
    table.insert(pids, tonumber(pid))
  end

  for _, pid in ipairs(pids) do
    vim.fn.system("kill -SIGUSR2 " .. pid)
    if vim.v.shell_error ~= 0 then
      vim.notify("Error updating Ghostty theme: " .. result, vim.log.levels.WARN)
    end
  end
end

function M.set_zellij_theme(theme)
  local config_path = vim.fn.expand("~/.config/zellij/config.kdl")
  local real_path = vim.fn.resolve(config_path)
  local cmd = string.format('sed -i\'.bak\' \'s/theme "[^"]*"/theme "%s"/\' %s', theme, real_path)
  local result = vim.fn.system({ "bash", "-c", cmd })
  if vim.v.shell_error ~= 0 then
    vim.notify("Error updating Zellij theme: " .. result, vim.log.levels.WARN)
  end
end

function M.set_delta_theme(theme)
  local config_path = vim.fn.expand("~/.config/git/config")
  local real_path = vim.fn.resolve(config_path)
  local cmd = string.format("sed -i'.bak' 's/features = .*/features = %s/' %s", theme, real_path)

  local result = vim.fn.system({ "bash", "-c", cmd })
  if vim.v.shell_error ~= 0 then
    vim.notify("Error updating Delta theme for git: " .. result, vim.log.levels.WARN)
  end
end

function M.set_yazi_theme(theme)
  local config_path = vim.fn.expand("~/.config/yazi/theme.toml")
  local real_path = vim.fn.resolve(config_path)
  local cmd = string.format('sed -i\'.bak\' \'s/use = "[^"]*"/use = "%s"/\' %s', theme, real_path)

  local result = vim.fn.system({ "bash", "-c", cmd })
  if vim.v.shell_error ~= 0 then
    vim.notify("Error updating Yazi theme for git: " .. result, vim.log.levels.WARN)
  end
end

function M.set_wezterm_theme(theme)
  local config_path = vim.fn.expand("~/.config/wezterm/wezterm.lua")
  local real_path = vim.fn.resolve(config_path)
  local cmd = string.format('sed -i\'.bak\' \'s/color_scheme = "[^"]*"/color_scheme = "%s"/\' %s', theme, real_path)

  local result = vim.fn.system({ "bash", "-c", cmd })
  if vim.v.shell_error ~= 0 then
    vim.notify("Error updating Wezterm theme: " .. result, vim.log.levels.WARN)
  end
end

--- Set up terminal background synchronization
--- https://github.com/nvim-mini/mini.misc/blob/main/lua/mini/misc.lua
---
--- What it does:
--- - Creates autocommands for |ColorScheme| and |VimResume| events, which
---   change terminal background to have same color as |guibg| of |hl-Normal|.
--- - Creates autocommands for |VimLeavePre| and |VimSuspend| events which resets
---   terminal background back to it's original value.
--- - Synchronizes background immediately to allow not depend on loading order.
---
--- Primary use case is to remove possible "frame" around current Neovim instance
--- which appears if Neovim's |hl-Normal| background color differs from what is
--- used by terminal emulator itself.
---
--- Works only on Neovim>=0.10.
M.setup_termbg_sync = function(group)
  -- Set up reset
  -- local reset = function()
  --   io.stdout:write("\027]111\027\\")
  -- end
  -- vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, { group = group, callback = reset })

  -- Set up sync
  local sync = function()
    local light = vim.o.background == "light"
    -- Set underline to undercurls
    vim.cmd([[ highlight Underlined cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight @markup.underline cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight DiagnosticUnderlineOk cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight DiagnosticUnderlineHint cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight DiagnosticUnderlineInfo cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight DiagnosticUnderlineWarn cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight DiagnosticUnderlineError cterm=undercurl gui=undercurl ]])

    -- Update Ghostty
    -- TODO: there's a bug in ghostty which causes new tabs to not respect the theme change when using auto light/dark themes
    -- M.set_ghostty_theme(M.config.ghostty)

    -- Update other terminals
    if light then
      M.set_ghostty_theme(M.config.ghostty.light)
      vim.fn.system("kitty +kitten themes --reload-in=all " .. M.config.kitty.light)
      vim.fn.system("kitten @ load-config")
      M.set_zellij_theme(M.config.zellij.light)
      M.set_delta_theme(M.config.delta.light)
      M.set_yazi_theme(M.config.yazi.light)
      -- M.set_wezterm_theme(M.config.wezterm.light)
    else
      M.set_ghostty_theme(M.config.ghostty.dark)
      vim.fn.system("kitty +kitten themes --reload-in=all " .. M.config.kitty.dark)
      vim.fn.system("kitten @ load-config")
      M.set_zellij_theme(M.config.zellij.dark)
      M.set_delta_theme(M.config.delta.dark)
      M.set_yazi_theme(M.config.yazi.dark)
      -- M.set_wezterm_theme(M.config.wezterm.dark)
    end

    -- TODO: There might be an issue with ghostty where if you had a neovim session before and then you close it, and then the terminal changes theme, the background color won't update until you restart ghostty
    -- local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    -- if not normal.bg then
    -- return reset()
    -- end
    -- NOTE: use `io.stdout` instead of `io.write` to ensure correct target
    -- Otherwise after `io.output(file); file:close()` there is an error
    -- io.stdout:write(string.format("\027]11;#%06x\007", normal.bg))
  end
  vim.api.nvim_create_autocmd({ "VimResume", "ColorScheme" }, { group = group, callback = sync })

  -- Sync immediately
  sync()
end

return M
