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
M.colorscheme_light = "zenbones"
M.colorscheme_dark = "zenbones"
M.kitty_theme_light = "melange_light"
M.kitty_theme_dark = "melange_dark"
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
				vim.fn.system("kitty +kitten themes " .. M.kitty_theme_light)
			elseif vim.o.background == "dark" then
				vim.fn.system("kitty +kitten themes " .. M.kitty_theme_dark)
			else
				vim.fn.system("kitty +kitten themes " .. M.kitty_theme_dark)
			end
		end,
	})
	M.set_from_os()
end

return M
