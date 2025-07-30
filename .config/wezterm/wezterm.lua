-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("Geist Mono", { weight = 480 })
config.font_size = 14.0
config.line_height = 1.4
config.color_scheme = "Modus Vivendi (Gogh)"
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

-- top bar
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)

-- session management
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.apply_to_config(config)
workspace_switcher.get_choices = function(opts)
	if opts == nil then
		opts = { extra_args = "" }
	end
	local choices = {}

	choices, opts.workspace_ids = workspace_switcher.choices.get_workspace_elements(choices)
	-- choices = workspace_switcher.choices.get_zoxide_elements(choices, opts)
	local success, stdout, stderr =
		wezterm.run_child_process({ "/usr/local/bin/fish", "-c", "fd -t d -d 1 . ~/Developer" })
	if not success then
		wezterm.log_error(stderr)
	end
	for _, path in ipairs(wezterm.split_by_newlines(stdout)) do
		local updated_path = string.gsub(path, wezterm.home_dir, "~")
		if not opts.workspace_ids[updated_path] then
			table.insert(choices, {
				id = path,
				label = updated_path,
			})
		end
	end
	return choices
end

-- keybinds
config.keys = {
	{
		key = "p",
		mods = "CMD",
		action = workspace_switcher.switch_workspace(),
	},
	{
		key = "p",
		mods = "CMD|SHIFT",
		action = workspace_switcher.switch_to_prev_workspace(),
	},
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "Enter",
		mods = "CMD|SHIFT",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "[",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "]",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(1),
	},
}

return config
