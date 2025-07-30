-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("Geist Mono", { weight = 480 })
config.font_size = 14.0
config.line_height = 1.4

config.underline_position = -8
config.underline_thickness = 3
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_background_opacity = 0.80
config.macos_window_background_blur = 26

return config
