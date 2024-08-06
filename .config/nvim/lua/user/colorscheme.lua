---@class user.colorscheme
local M = {}

-- TODO: auto switch theme to light/dark based on macos appearance
-- https://github.com/jascha030/macos-nvim-dark-mode
function M.os_is_dark()
	return (vim.fn.system(
		[[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
	)):find("dark") ~= nil
end
local initialDark = M.os_is_dark()

-- CHANGE COLORSCHME HERE
M.colorscheme_light = "modus"
M.colorscheme_dark = "modus"
M.ghostty_theme_light = "modus_light"
M.ghostty_theme_dark = "modus_dark"
M.ghostty_custom_theme = true
M.kitty_theme_light = "modus_light"
M.kitty_theme_dark = "modus_dark"
M.enable_auto_switch = true
M.default_light = false
M.initialColorScheme = nil

if M.enable_auto_switch then
	if initialDark then
		vim.o.background = "dark"
		M.initialColorScheme = M.colorscheme_dark
	else
		vim.o.background = "light"
		M.initialColorScheme = M.colorscheme_light
	end
else
	if M.default_light then
		vim.o.background = "light"
		M.initialColorScheme = M.colorscheme_light
	else
		vim.o.background = "dark"
		M.initialColorScheme = M.colorscheme_dark
	end
end

---@param light boolean
function M.set_colorscheme(light)
	vim.o.termguicolors = true
	if light then
		vim.o.background = "light"
		vim.cmd.colorscheme(M.colorscheme_light)
	else
		vim.o.background = "dark"
		vim.cmd.colorscheme(M.colorscheme_dark)
	end
end

function M.set_from_os()
	if not M.enable_auto_switch then
		M.set_colorscheme(M.default_light)
		return
	end
	if M.os_is_dark() then
		M.set_colorscheme(false)
	else
		M.set_colorscheme(true)
	end
end

function M.get_colorscheme()
	if not M.enable_auto_switch then
		if M.default_light then
			return M.colorscheme_light
		else
			return M.colorscheme_dark
		end
	end

	if vim.o.background == "light" then
		return M.colorscheme_light
	else
		return M.colorscheme_dark
	end
end

local term = os.getenv("TERM")
function M.init()
	vim.api.nvim_create_autocmd("Signal", {
		pattern = "*",
		callback = function()
			M.set_from_os()
		end,
	})
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			if vim.o.background == "light" then
				if term == "xterm-kitty" then
					vim.fn.system("kitty +kitten themes " .. M.kitty_theme_light)
				elseif term == "xterm-ghostty" then
					if M.ghostty_custom_theme then
						M.set_ghostty_theme(M.ghostty_theme_light)
					else
						vim.fn.system(
							"sed -i'.bak' 's/theme = .*/theme = "
								.. M.ghostty_theme_light
								.. "/' (readlink ~/.config/ghostty/config)"
						)
					end
				end
				-- vim.fn.system(
				-- 	'sed -i\'.bak\' \'s/theme "[^"]*"/theme "'
				-- 		.. M.terminal_theme_light
				-- 		.. "\"/' ~/.config/zellij/config.kdl"
				-- )
			elseif vim.o.background == "dark" then
				if term == "xterm-kitty" then
					vim.fn.system("kitty +kitten themes " .. M.kitty_theme_dark)
				elseif term == "xterm-ghostty" then
					if M.ghostty_custom_theme then
						M.set_ghostty_theme(M.ghostty_theme_dark)
					else
						vim.fn.system(
							"sed -i'.bak' 's/theme = .*/theme = "
								.. M.ghostty_theme_dark
								.. "/' (readlink ~/.config/ghostty/config)"
						)
					end
				end
				-- vim.fn.system(
				-- 	'sed -i\'.bak\' \'s/theme "[^"]*"/theme "'
				-- 		.. M.terminal_theme_dark
				-- 		.. "\"/' ~/.config/zellij/config.kdl"
				-- )
			else
				if term == "xterm-kitty" then
					vim.fn.system("kitty +kitten themes " .. M.kitty_theme_dark)
				elseif term == "xterm-ghostty" then
					vim.fn.system(
						"sed -i'.bak' 's/theme = .*/theme = "
							.. M.ghostty_theme_dark
							.. "/' (readlink ~/.config/ghostty/config)"
					)
				end
			end
		end,
	})
	M.set_from_os()
end

function M.switch_theme(theme)
	local theme_name, theme_type = theme:match("([^_]*)_([^_]*)")
	if theme_type == "light" then
		theme_type = "dark"
	else
		theme_type = "light"
	end
	return theme_name .. "_" .. theme_type
end

function M.set_ghostty_theme(theme)
	local base_config_path = vim.fn.expand("~/.config/ghostty/config")
	local theme_file_path = vim.fn.expand("~/.config/ghostty/" .. theme .. ".conf")

	-- Check if the theme file exists
	if vim.fn.filereadable(theme_file_path) == 0 then
		print("Theme file not found: " .. theme_file_path)
		return
	end

	local currentTheme = M.switch_theme(theme)

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

	print("Theme set to: " .. theme)
end

return M
