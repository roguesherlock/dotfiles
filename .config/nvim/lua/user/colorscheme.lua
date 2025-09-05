---@class user.colorscheme
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
    -- light = "modus",
    -- dark = "modus",
    -- light = "tokyonight",
    -- dark = "tokyonight",
    light = "default",
    dark = "default",
  },
  ghostty = {
    light = "Github-Light-High-Contrast",
    dark = "Black Metal",
    -- light = "tokyonight-day",
    -- dark = "tokyonight",
    custom_theme = false,
  },
  kitty = {
    -- light = "Modus Operandi",
    -- dark = "Modus Vivendi",
    light = "Tokyo Night Day",
    dark = "Tokyo Night",
  },
  wezterm = {
    light = "Modus Operandi (Gogh)",
    dark = "Modus Vivendi (Gogh)",
  },
  zellij = {
    -- light = "modus_operandi",
    -- dark = "modus_vivendi",
    light = "tokyo-night-light",
    dark = "tokyo-night",
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
  -- Set underline to undercurls
  vim.cmd([[ highlight Underlined cterm=undercurl gui=undercurl ]])
  vim.cmd([[ highlight @markup.underline cterm=undercurl gui=undercurl ]])
  vim.cmd([[ highlight DiagnosticUnderlineOk cterm=undercurl gui=undercurl ]])
  vim.cmd([[ highlight DiagnosticUnderlineHint cterm=undercurl gui=undercurl ]])
  vim.cmd([[ highlight DiagnosticUnderlineInfo cterm=undercurl gui=undercurl ]])
  vim.cmd([[ highlight DiagnosticUnderlineWarn cterm=undercurl gui=undercurl ]])
  vim.cmd([[ highlight DiagnosticUnderlineError cterm=undercurl gui=undercurl ]])

  -- Defer terminal theme updates
  vim.defer_fn(function()
    -- Update Ghostty
    M.set_ghostty_theme(M.config.ghostty, M.config.ghostty.custom_theme)

    -- Update other terminals
    if light then
      vim.fn.system("kitty +kitten themes --reload-in=all " .. M.config.kitty.light)
      vim.fn.system("kitten @ load-config")
      M.set_zellij_theme(M.config.zellij.light)
      M.set_delta_theme(M.config.delta.light)
      M.set_yazi_theme(M.config.yazi.light)
      -- M.set_wezterm_theme(M.config.wezterm.light)
    else
      vim.fn.system("kitty +kitten themes --reload-in=all " .. M.config.kitty.dark)
      vim.fn.system("kitten @ load-config")
      M.set_zellij_theme(M.config.zellij.dark)
      M.set_delta_theme(M.config.delta.dark)
      M.set_yazi_theme(M.config.yazi.dark)
      -- M.set_wezterm_theme(M.config.wezterm.dark)
    end
  end, 0)
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
  vim.validate({ config = { config, "table", true } })

  -- Merge user config with defaults
  M.config = vim.tbl_deep_extend("force", vim.deepcopy(M.config), config or {})

  -- Set initial theme
  M.set_from_os()
  M.setup_termbg_sync()

  -- Create autocommands
  vim.api.nvim_create_autocmd("Signal", {
    pattern = "*",
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

function M.set_ghostty_theme(theme, is_custom_theme)
  is_custom_theme = is_custom_theme or false
  if not is_custom_theme then
    -- vim.fn.system("sed -i'.bak' 's/theme = .*/theme = " .. ghostty_light_theme .. "/' (readlink ~/.config/ghostty/config)")
    local config_path = vim.fn.expand("~/.config/ghostty/config")
    local real_path = vim.fn.resolve(config_path)
    local light_dark_theme = string.format("light:%s,dark:%s", theme.light, theme.dark)
    -- local cmd = string.format("sed -i'.bak' 's/theme = .*/theme = %s/' %s", light_dark_theme, real_path)
    local cmd = string.format("sed -i'.bak' 's/^[ ]*theme[ ]*=.*$/theme = %s/' %s", light_dark_theme, real_path)
    local result = vim.fn.system({ "bash", "-c", cmd })
    if vim.v.shell_error ~= 0 then
      vim.notify("Error updating Ghostty theme: " .. result, vim.log.levels.WARN)
    end
    return
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
  local config_path = vim.fn.expand("~/.gitconfig")
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
--- - Checks if terminal emulator supports OSC 11 control sequence through
---   appropriate `stdout`. Stops if not.
--- - Creates autocommands for |ColorScheme| and |VimResume| events, which
---   change terminal background to have same color as |guibg| of |hl-Normal|.
--- - Creates autocommands for |VimLeavePre| and |VimSuspend| events which set
---   terminal background back to the color at the time this function was
---   called first time in current session.
--- - Synchronizes background immediately to allow not depend on loading order.
---
--- Primary use case is to remove possible "frame" around current Neovim instance
--- which appears if Neovim's |hl-Normal| background color differs from what is
--- used by terminal emulator itself.
---
--- Works only on Neovim>=0.10.
M.setup_termbg_sync = function()
  -- Handling `'\027]11;?\007'` response was added in Neovim 0.10
  if vim.fn.has("nvim-0.10") == 0 then
    return vim.notify("`setup_termbg_sync()` requires Neovim>=0.10", "WARN")
  end

  -- Proceed only if there is a valid stdout to use
  local has_stdout_tty = false
  for _, ui in ipairs(vim.api.nvim_list_uis()) do
    has_stdout_tty = has_stdout_tty or ui.stdout_tty
  end
  if not has_stdout_tty then
    return
  end

  local augroup = vim.api.nvim_create_augroup("TermbgSync", { clear = true })
  local track_au_id, bad_responses, had_proper_response = nil, {}, false
  local f = function(args)
    -- Process proper response only once
    if had_proper_response then
      return
    end

    -- Neovim=0.10 uses string sequence as response, while Neovim>=0.11 sets it
    -- in `sequence` table field
    local seq = type(args.data) == "table" and args.data.sequence or args.data
    local ok, termbg = pcall(M.parse_osc11, seq)
    if not (ok and type(termbg) == "string") then
      return table.insert(bad_responses, seq)
    end
    had_proper_response = true
    pcall(vim.api.nvim_del_autocmd, track_au_id)

    -- Set up reset to the color returned from the very first call
    M.termbg_init = M.termbg_init or termbg
    local reset = function()
      io.stdout:write("\027]111" .. "\007")
    end
    vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, { group = augroup, callback = reset })

    -- Set up sync
    local sync = function()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
      if normal.bg == nil then
        return reset()
      end
      -- NOTE: use `io.stdout` instead of `io.write` to ensure correct target
      -- Otherwise after `io.output(file); file:close()` there is an error
      io.stdout:write(string.format("\027]11;#%06x\007", normal.bg))
    end
    vim.api.nvim_create_autocmd({ "VimResume", "ColorScheme" }, { group = augroup, callback = sync })

    -- Sync immediately
    sync()
  end

  -- Ask about current background color and process the proper response.
  -- NOTE: do not use `once = true` as Neovim itself triggers `TermResponse`
  -- events during startup, so this should wait until the proper one.
  track_au_id = vim.api.nvim_create_autocmd("TermResponse", { group = augroup, callback = f, nested = true })
  io.stdout:write("\027]11;?\007")
  vim.defer_fn(function()
    if had_proper_response then
      return
    end
    pcall(vim.api.nvim_del_augroup_by_id, augroup)
    local bad_suffix = #bad_responses == 0 and "" or (", only these: " .. vim.inspect(bad_responses))
    local msg = "`setup_termbg_sync()` did not get proper response from terminal emulator" .. bad_suffix
    vim.notify(msg, "WARN")
  end, 1000)
end

-- Source: 'runtime/lua/vim/_defaults.lua' in Neovim source
M.parse_osc11 = function(x)
  local r, g, b = x:match("^\027%]11;rgb:(%x+)/(%x+)/(%x+)$")
  if not (r and g and b) then
    local a
    r, g, b, a = x:match("^\027%]11;rgba:(%x+)/(%x+)/(%x+)/(%x+)$")
    if not (a and a:len() <= 4) then
      return
    end
  end
  if not (r and g and b) then
    return
  end
  if not (r:len() <= 4 and g:len() <= 4 and b:len() <= 4) then
    return
  end
  local parse_osc_hex = function(c)
    return c:len() == 1 and (c .. c) or c:sub(1, 2)
  end
  return "#" .. parse_osc_hex(r) .. parse_osc_hex(g) .. parse_osc_hex(b)
end

return M
