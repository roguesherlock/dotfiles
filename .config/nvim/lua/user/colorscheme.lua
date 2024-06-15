---@class user.colorscheme
local M = {}

-- TODO: auto switch theme to light/dark based on macos appearance
-- https://github.com/jascha030/macos-nvim-dark-mode
function M.os_is_dark()
	return (vim.fn.system(
		[[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
	)):find("dark") ~= nil
end

-- CHANGE COLORSCHME HERE
-- M.colorscheme_light = "zenbones"
-- M.colorscheme_dark = "zenbones"
-- M.terminal_theme_light = "zenbones_light"
-- M.terminal_theme_dark = "zenbones_dark"
-- M.colorscheme_light = "everforest"
-- M.colorscheme_dark = "everforest"
-- M.terminal_theme_light = "zenbones_light"
-- M.terminal_theme_dark = "Everblush"
-- M.colorscheme_light = "rose-pine"
-- M.colorscheme_dark = "rose-pine"
M.colorscheme_light = "modus"
M.colorscheme_dark = "modus"
M.terminal_theme_light = "Builtin Tango Light"
M.terminal_theme_dark = "Builtin Tango Dark"
M.enable_auto_switch = false
M.default_light = false

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
					vim.fn.system("kitty +kitten themes " .. M.terminal_theme_light)
				elseif term == "xterm-ghostty" then
					vim.fn.system(
						"sed -i'.bak' 's/theme = .*/theme = "
							.. M.terminal_theme_light
							.. "/' (readlink ~/.config/ghostty/config)"
					)
				end
				-- vim.fn.system(
				-- 	'sed -i\'.bak\' \'s/theme "[^"]*"/theme "'
				-- 		.. M.terminal_theme_light
				-- 		.. "\"/' ~/.config/zellij/config.kdl"
				-- )
			elseif vim.o.background == "dark" then
				if term == "xterm-kitty" then
					vim.fn.system("kitty +kitten themes " .. M.terminal_theme_dark)
				elseif term == "xterm-ghostty" then
					vim.fn.system(
						"sed -i'.bak' 's/theme = .*/theme = "
							.. M.terminal_theme_dark
							.. "/' (readlink ~/.config/ghostty/config)"
					)
				end
				-- vim.fn.system(
				-- 	'sed -i\'.bak\' \'s/theme "[^"]*"/theme "'
				-- 		.. M.terminal_theme_dark
				-- 		.. "\"/' ~/.config/zellij/config.kdl"
				-- )
			else
				if term == "xterm-kitty" then
					vim.fn.system("kitty +kitten themes " .. M.terminal_theme_dark)
				elseif term == "xterm-ghostty" then
					vim.fn.system(
						"sed -i'.bak' 's/theme = .*/theme = "
							.. M.terminal_theme_dark
							.. "/' (readlink ~/.config/ghostty/config)"
					)
				end
			end
		end,
	})
	M.set_from_os()
end

return M
