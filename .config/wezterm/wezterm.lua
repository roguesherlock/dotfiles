-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Returns a bool based on whether the host operating system's
-- appearance is light or dark.
local function is_dark()
	-- wezterm.gui is not always available, depending on what
	-- environment wezterm is operating in. Just return true
	-- if it's not defined.
	if wezterm.gui then
		-- Some systems report appearance like "Dark High Contrast"
		-- so let's just look for the string "Dark" and if we find
		-- it assume appearance is dark.
		return wezterm.gui.get_appearance():find("Dark")
	end
	return true
end

local function get_colorscheme(appearance)
	local config = {}
	if appearance:find("Dark") then
		config.color_scheme = "Modus Vivendi (Gogh)"
		-- local result, mod = pcall(require, "lua/kanso-zen")
		-- if result then
		-- 	config.force_reverse_video_cursor = mod.force_reverse_video_cursor
		-- 	config.colors = mod.colors
		-- end
	else
		config.color_scheme = "Modus Operandi (Gogh)"
		-- local result, mod = pcall(require, "lua/kanso-pearl")
		-- if result then
		-- 	config.force_reverse_video_cursor = mod.force_reverse_video_cursor
		-- 	config.colors = mod.colors
		-- end
	end
	return config
end

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.font = wezterm.font("Geist Mono", { weight = 480 })
config.font = wezterm.font("Berkeley Mono Variable")
config.font_size = 14.0
config.line_height = 1.2
config.window_frame = {
	font = wezterm.font({ family = "Inter Display", weight = 500 }),
	font_size = 11,
}

-- Deep merge function
local function deep_merge(target, source)
	for key, value in pairs(source) do
		if type(value) == "table" and type(target[key]) == "table" then
			deep_merge(target[key], value)
		else
			target[key] = value
		end
	end
	return target
end

local initial_appearnce = "Dark"
if wezterm.gui then
	-- Some systems report appearance like "Dark High Contrast"
	-- so let's just look for the string "Dark" and if we find
	-- it assume appearance is dark.
	initial_appearnce = wezterm.gui.get_appearance()
end

local colors_config = get_colorscheme(initial_appearnce)
deep_merge(config, colors_config)

config.underline_position = -6
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
bar.apply_to_config(config, {
	modules = {
		workspace = {
			color = 6,
		},
		zoom = {
			enabled = true,
		},
		hostname = {
			enabled = false,
			color = 7,
		},
		username = {
			enabled = false,
		},
	},
})

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
	{
		key = "l",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "h",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local colors = get_colorscheme(window:get_appearance())

	if overrides.color_scheme == colors.color_scheme then
		return
	end

	-- TODO: figure out a way to do this nicely
	bar.apply_to_config(overrides, {
		modules = {
			workspace = {
				color = 6,
			},
			zoom = {
				enabled = true,
			},
			hostname = {
				enabled = false,
				color = 7,
			},
			username = {
				enabled = false,
			},
		},
	})

	deep_merge(overrides, colors)

	window:set_config_overrides(overrides)
end)

return config
