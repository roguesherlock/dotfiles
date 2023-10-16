-- Pull in the wezterm API
local wezterm = require("wezterm")

-- local colors = require("lua/rose-pine").colors()
-- local window_frame = require("lua/rose-pine").window_frame()

-- local colors = require("lua/everforest").colors()
-- local window_frame = require("lua/everforest").window_frame()
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("CommitMono")
config.font_size = 14.0
config.line_height = 1.21

-- config.colors = colors
-- config.window_frame = window_frame
config.color_scheme = "Everforest Dark (Gogh)"

-- local appearance = wezterm.gui.get_appearance()
-- if appearance:find "Dark" then
--   -- config.color_scheme = "Catppuccin Frappe"
--   config.color_scheme = "GruvboxDark"
-- else
--   -- config.color_scheme = "Catppuccin Latte"
--   config.color_scheme = "Gruvbox Light"
-- end

config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.adjust_window_size_when_changing_font_size = false

config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false

-- config.enable_kitty_keyboard = true
-- config.enable_csi_u_key_encoding = false

config.window_background_opacity = 0.7
config.macos_window_background_blur = 20

-- and finally, return the configuration to wezterm
return config
