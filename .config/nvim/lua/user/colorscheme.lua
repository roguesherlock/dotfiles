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
    light = "lunaperche",
    dark = "lunaperche",
  },
  ghostty = {
    light = "Github-Light-High-Contrast",
    dark = "Black Metal",
    -- light = "catppuccin-latte",
    -- dark = "catppuccin-mocha",
    custom_theme = false,
  },
  kitty = {
    light = "Modus Operandi",
    dark = "Modus Vivendi",
  },
  wezterm = {
    light = "Modus Operandi (Gogh)",
    dark = "Modus Vivendi (Gogh)",
  },
  zellij = {
    light = "modus_operandi",
    dark = "modus_vivendi",
  },
  delta = {
    light = "catppuccin-latte",
    dark = "catppuccin-frappe",
  },
  yazi = {
    -- light = "catppuccin-latte",
    -- dark = "catppuccin-frappe",
    light = "kanso-pearl",
    dark = "kanso-zen",
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
  end
  M.set_colorscheme(not M.os_is_dark())
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

return M
