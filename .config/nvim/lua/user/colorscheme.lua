---@class user.colorscheme
local M = {}
-- Set this as early as possible
-- TODO: figure how to do this for other os
vim.opt.background = vim.fn.system([[defaults read -g AppleInterfaceStyle 2>/dev/null]]):find("Dark") and "dark"
  or "light"

-- colors, look at colors()
M.config = {
  opts = {
    enable_auto_switch = true,
    default_light = false,
    -- if enabled, would also set the theme when toggling the theme rather than just the background
    set_theme_on_auto_switch = true,
  },
  nvim = {
    light = "modus",
    dark = "modus",
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

function M.os_is_dark()
  -- return (vim.fn.system(
  --   [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
  -- )):find("dark") ~= nil
  local handle = io.popen([[defaults read -g AppleInterfaceStyle 2>/dev/null]])
  local result = handle and handle:read("*a"):gsub("%s+", "") or ""
  if handle then
    handle:close()
  end
  if result == "Dark" then
    return true
  else
    return false
  end
end

---@param light boolean
function M.set_colorscheme(light)
  local background = "dark"
  local colorscheme = M.config.nvim.dark
  if light then
    background = "light"
    colorscheme = M.config.nvim.light
  end
  vim.opt.background = background
  if M.config.opts.set_theme_on_auto_switch then
    vim.cmd("colorscheme " .. colorscheme)
  end
  vim.defer_fn(function()
    if light then
      vim.fn.system("kitty +kitten themes " .. M.config.kitty.light)
      M.set_ghostty_theme(M.config.ghostty.light, M.config.ghostty.custom_theme)
      M.set_zellij_theme(M.config.zellij.light)
      M.set_delta_theme(M.config.delta.light)
      M.set_yazi_theme(M.config.yazi.light)
    else
      vim.fn.system("kitty +kitten themes " .. M.config.kitty.dark)
      M.set_ghostty_theme(M.config.ghostty.dark, M.config.ghostty.custom_theme)
      M.set_zellij_theme(M.config.zellij.dark)
      M.set_delta_theme(M.config.delta.dark)
      M.set_yazi_theme(M.config.yazi.dark)
    end
  end, 0)
end

function M.set_from_os()
  if not M.config.opts.enable_auto_switch then
    M.set_colorscheme(M.config.opts.default_light)
  end
  if M.os_is_dark() then
    M.set_colorscheme(false)
  else
    M.set_colorscheme(true)
  end
end

function M.get_colorscheme()
  if not M.config.opts.enable_auto_switch then
    if M.config.opts.default_light then
      return M.config.nvim.light
    else
      return M.config.nvim.dark
    end
  end

  if M.os_is_dark() then
    return M.config.nvim.dark
  else
    return M.config.nvim.light
  end

  -- if vim.o.background == "light" then
  --   return M.config.nvim.light
  -- else
  --   return M.config.nvim.dark
  -- end
end

function M.setup(config)
  -- Validate config is a table
  vim.validate({ config = { config, "table", true } })

  -- Merge user config with defaults
  M.config = vim.tbl_deep_extend("force", vim.deepcopy(M.config), config or {})

  M.set_from_os()

  local term = os.getenv("TERM")
  vim.api.nvim_create_autocmd("Signal", {
    pattern = "*",
    callback = function()
      print("Theme updated from os")
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
    local cmd = string.format("sed -i'.bak' 's/theme = .*/theme = %s/' %s", theme, real_path)
    local result = vim.fn.system({ "bash", "-c", cmd })
    if vim.v.shell_error ~= 0 then
      print("Error updating Ghostty theme: " .. result)
    end
    return
  end
  -- local function switch__theme(theme)
  --   local theme_name, theme_type = theme:match("([^_]*)_([^_]*)")
  --   if theme_type == "light" then
  --     theme_type = "dark"
  --   else
  --     theme_type = "light"
  --   end
  --   return theme_name .. "_" .. theme_type
  -- end
  -- local base_config_path = vim.fn.expand("~/.config/ghostty/config")
  -- local theme_file_path = vim.fn.expand("~/.config/ghostty/" .. theme .. ".conf")
  --
  -- -- Check if the theme file exists
  -- if vim.fn.filereadable(theme_file_path) == 0 then
  --   print("Theme file not found: " .. theme_file_path)
  --   return
  -- end
  --
  -- local currentTheme = switch_theme(theme)
  --
  -- -- Read the content of the theme file
  -- local theme_content = vim.fn.readfile(theme_file_path)
  --
  -- -- Read the current content of the base config file
  -- local base_config_content = vim.fn.readfile(base_config_path)
  --
  -- -- Find the start and end indices of the current theme section
  -- local start_index, end_index
  -- local in_theme_section = false
  -- for i, line in ipairs(base_config_content) do
  --   if line:match("^# %s*" .. theme .. "$") then
  --     return
  --   elseif line:match("^# %s*" .. currentTheme .. "$") then
  --     start_index = i
  --     in_theme_section = true
  --   elseif line:match("^# End*$") and in_theme_section then
  --     end_index = i
  --     break
  --   end
  -- end
  --
  -- -- Remove the current theme section if found
  -- if start_index and end_index then
  --   for i = end_index, start_index, -1 do
  --     table.remove(base_config_content, i)
  --   end
  -- end
  --
  -- -- Insert the new theme content at the position where the old theme was removed
  -- -- or at the end if no theme section was found
  -- local insert_position = start_index or (#base_config_content + 1)
  -- for i, line in ipairs(theme_content) do
  --   table.insert(base_config_content, insert_position, line)
  --   insert_position = insert_position + 1
  -- end
  --
  -- -- Write the updated content back to the base config file
  -- vim.fn.writefile(base_config_content, base_config_path)
  --
  -- -- print("Theme set to: " .. theme)
end

function M.set_zellij_theme(theme)
  local config_path = vim.fn.expand("~/.config/zellij/config.kdl")
  local real_path = vim.fn.resolve(config_path)
  local cmd = string.format('sed -i\'.bak\' \'s/theme "[^"]*"/theme "%s"/\' %s', theme, real_path)
  local result = vim.fn.system({ "bash", "-c", cmd })
  if vim.v.shell_error ~= 0 then
    print("Error updating Zellij theme: " .. result)
  end
end

function M.set_delta_theme(theme)
  local config_path = vim.fn.expand("~/.gitconfig")
  local real_path = vim.fn.resolve(config_path)
  local cmd = string.format("sed -i'.bak' 's/features = .*/features = %s/' %s", theme, real_path)

  local result = vim.fn.system({ "bash", "-c", cmd })
  if vim.v.shell_error ~= 0 then
    print("Error updating Delta theme for git: " .. result)
  end
end

function M.set_yazi_theme(theme)
  local config_path = vim.fn.expand("~/.config/yazi/theme.toml")
  local real_path = vim.fn.resolve(config_path)
  local cmd = string.format('sed -i\'.bak\' \'s/use = "[^"]*"/use = "%s"/\' %s', theme, real_path)

  local result = vim.fn.system({ "bash", "-c", cmd })
  if vim.v.shell_error ~= 0 then
    print("Error updating Yazi theme for git: " .. result)
  end
end

return M
