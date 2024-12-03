---@class user.colorscheme
local M = {}

-- colors, look at colors()
local theme_config = {
  opts = {
    enable_auto_switch = true,
    default_light = false,
  },
  nvim = {
    light = "modus_light",
    dark = "modus_dark",
  },
  ghostty = {
    light = "modus_light",
    dark = "modus_dark",
    custom_theme = false,
  },
  kitty = {
    light = "Modus Operandi",
    dark = "Modus Vivendi",
  },
  zellij = {
    light = "catppuccin-latte",
    dark = "catppuccin-frappe",
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

-- TODO: auto switch theme to light/dark based on macos appearance
-- https://github.com/jascha030/macos-nvim-dark-mode
local os_is_dark = function()
  return (vim.fn.system(
    [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
  )):find("dark") ~= nil
end

---@param light boolean
local set_colorscheme = function(light)
  if light then
    vim.opt.background = "light"
    vim.cmd("colorscheme " .. theme_config.nvim.light)
  else
    vim.opt.background = "dark"
    vim.cmd("colorscheme " .. theme_config.nvim.dark)
  end
end

local set_from_os = function()
  if not theme_config.opts.enable_auto_switch then
    set_colorscheme(theme_config.opts.default_light)
  end
  if os_is_dark() then
    set_colorscheme(false)
  else
    set_colorscheme(true)
  end
end

local function switch_theme(theme)
  local theme_name, theme_type = theme:match("([^_]*)_([^_]*)")
  if theme_type == "light" then
    theme_type = "dark"
  else
    theme_type = "light"
  end
  return theme_name .. "_" .. theme_type
end

local function set_ghostty_theme(theme, is_custom_theme)
  is_custom_theme = is_custom_theme or false
  if not is_custom_theme then
    -- vim.fn.system("sed -i'.bak' 's/theme = .*/theme = " .. ghostty_light_theme .. "/' (readlink ~/.config/ghostty/config)")
    local config_path = vim.fn.expand("~/.config/ghostty/config")
    local real_path = vim.fn.resolve(config_path)
    local cmd = string.format("sed -i'.bak' 's/theme = .*/theme = %s/' %s", theme, real_path)
    local result = vim.fn.system({ "bash", "-c", cmd })
    if vim.v.shell_error ~= 0 then
      print("Error updating Ghostty theme: " .. result)
    end
    return
  end
  local base_config_path = vim.fn.expand("~/.config/ghostty/config")
  local theme_file_path = vim.fn.expand("~/.config/ghostty/" .. theme .. ".conf")

  -- Check if the theme file exists
  if vim.fn.filereadable(theme_file_path) == 0 then
    print("Theme file not found: " .. theme_file_path)
    return
  end

  local currentTheme = switch_theme(theme)

  -- Read the content of the theme file
  local theme_content = vim.fn.readfile(theme_file_path)

  -- Read the current content of the base config file
  local base_config_content = vim.fn.readfile(base_config_path)

  -- Find the start and end indices of the current theme section
  local start_index, end_index
  local in_theme_section = false
  for i, line in ipairs(base_config_content) do
    if line:match("^# %s*" .. theme .. "$") then
      return
    elseif line:match("^# %s*" .. currentTheme .. "$") then
      start_index = i
      in_theme_section = true
    elseif line:match("^# End*$") and in_theme_section then
      end_index = i
      break
    end
  end

  -- Remove the current theme section if found
  if start_index and end_index then
    for i = end_index, start_index, -1 do
      table.remove(base_config_content, i)
    end
  end

  -- Insert the new theme content at the position where the old theme was removed
  -- or at the end if no theme section was found
  local insert_position = start_index or (#base_config_content + 1)
  for i, line in ipairs(theme_content) do
    table.insert(base_config_content, insert_position, line)
    insert_position = insert_position + 1
  end

  -- Write the updated content back to the base config file
  vim.fn.writefile(base_config_content, base_config_path)

  -- print("Theme set to: " .. theme)
end

local function set_zellij_theme(theme)
  local config_path = vim.fn.expand("~/.config/zellij/config.kdl")
  local real_path = vim.fn.resolve(config_path)
  local cmd = string.format('sed -i\'.bak\' \'s/theme "[^"]*"/theme "%s"/\' %s', theme, real_path)
  local result = vim.fn.system({ "bash", "-c", cmd })
  if vim.v.shell_error ~= 0 then
    print("Error updating Zellij theme: " .. result)
  end
  return
end

local function set_delta_theme(theme)
  local config_path = vim.fn.expand("~/.gitconfig")
  local real_path = vim.fn.resolve(config_path)
  local cmd = string.format("sed -i'.bak' 's/features = .*/features = %s/' %s", theme, real_path)

  local result = vim.fn.system({ "bash", "-c", cmd })
  if vim.v.shell_error ~= 0 then
    print("Error updating Delta theme for git: " .. result)
  end
end

local function set_yazi_theme(theme)
  local config_path = vim.fn.expand("~/.config/yazi/theme.toml")
  local real_path = vim.fn.resolve(config_path)
  local cmd = string.format('sed -i\'.bak\' \'s/use = "[^"]*"/use = "%s"/\' %s', theme, real_path)

  local result = vim.fn.system({ "bash", "-c", cmd })
  if vim.v.shell_error ~= 0 then
    print("Error updating Yazi theme for git: " .. result)
  end
end

local function colors()
  vim.opt.background = "dark"

  local term = os.getenv("TERM")
  vim.api.nvim_create_autocmd("Signal", {
    pattern = "*",
    callback = function()
      set_from_os()
    end,
  })

  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      if vim.o.background == "light" then
        vim.fn.system("kitty +kitten themes " .. theme_config.kitty.light)
        set_ghostty_theme(theme_config.ghostty.light, theme_config.ghostty.custom_theme)
        set_zellij_theme(theme_config.zellij.light)
        set_delta_theme(theme_config.delta.light)
        set_yazi_theme(theme_config.yazi.light)
      else
        vim.fn.system("kitty +kitten themes " .. theme_config.kitty.dark)
        set_ghostty_theme(theme_config.ghostty.dark, theme_config.ghostty.custom_theme)
        set_zellij_theme(theme_config.zellij.dark)
        set_delta_theme(theme_config.delta.dark)
        set_yazi_theme(theme_config.yazi.dark)
      end
    end,
  })

  vim.api.nvim_create_user_command("Light", function()
    set_colorscheme(true)
  end, {})
  vim.api.nvim_create_user_command("Dark", function()
    set_colorscheme(false)
  end, {})

  vim.api.nvim_command("Catppuccin")
  -- set_from_os()
end

colors()


