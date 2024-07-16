-- TODO: auto switch theme to light/dark based on macos appearance
-- https://github.com/jascha030/macos-nvim-dark-mode
local function os_is_dark()
	return (vim.fn.system(
		[[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
	)):find("dark") ~= nil
end

local initialDark = os_is_dark()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- CHANGE COLORSCHME HERE
local colorscheme_light = "modus"
local colorscheme_dark = "modus"
local terminal_theme_light = "iceberg-light"
local terminal_theme_dark = "Builtin Pastel Dark"
local enable_auto_switch = true
local default_light = false
local initialColorScheme = nil

if enable_auto_switch then
	if initialDark then
		vim.o.background = "dark"
		initialColorScheme = colorscheme_dark
	else
		vim.o.background = "light"
		initialColorScheme = colorscheme_light
	end
else
	if default_light then
		vim.o.background = "light"
		initialColorScheme = colorscheme_light
	else
		vim.o.background = "dark"
		initialColorScheme = colorscheme_dark
	end
end

-- TODO: things to fix
-- 1. remove enter to insert completion item. Always use tab
-- 2. scroll with ctrl+n/p in completion hover
-- 3. scroll with ctrl+n/p in telescope and lsp hover
-- 4. auto switch theme to light/dark based on macos appearance
require("lazy").setup({
	spec = {
		-- add LazyVim and import its plugins
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				-- we have to set this here too because otherwise lazyvim will set it's default colorscheme first,
				-- which will cause it to flicker when we set our colorscheme at the end of initialization
				colorscheme = initialColorScheme,
			},
		},
		{
			import = "plugins",
		},
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	install = {
		colorscheme = {
			"mcchrish/zenbones.nvim",
			"rose-pine/neovim",
			"savq/melange-nvim",
			"miikanissi/modus-themes.nvim",
			-- "EdenEast/nightfox.nvim",
			"sainnhe/gruvbox-material",
			"tokyonight",
		},
	},
	checker = {
		enabled = true,
	}, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

---@param light boolean
local function set_colorscheme(light)
	vim.o.termguicolors = true
	if light then
		vim.o.background = "light"
		vim.cmd.colorscheme(colorscheme_light)
	else
		vim.o.background = "dark"
		vim.cmd.colorscheme(colorscheme_dark)
	end
end

local function set_from_os()
	if not enable_auto_switch then
		set_colorscheme(default_light)
		return
	end
	if os_is_dark() then
		set_colorscheme(false)
	else
		set_colorscheme(true)
	end
end

local function get_colorscheme()
	if not enable_auto_switch then
		if default_light then
			return colorscheme_light
		else
			return colorscheme_dark
		end
	end
	if os_is_dark() then
		return colorscheme_dark
	else
		return colorscheme_light
	end
end

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
			if term == "xterm-kitty" then
				vim.fn.system("kitty +kitten themes " .. terminal_theme_light)
			elseif term == "xterm-ghostty" then
				vim.fn.system(
					"sed -i'.bak' 's/theme = .*/theme = "
						.. terminal_theme_light
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
				vim.fn.system("kitty +kitten themes " .. terminal_theme_dark)
			elseif term == "xterm-ghostty" then
				vim.fn.system(
					"sed -i'.bak' 's/theme = .*/theme = "
						.. terminal_theme_dark
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
				vim.fn.system("kitty +kitten themes " .. terminal_theme_dark)
			elseif term == "xterm-ghostty" then
				vim.fn.system(
					"sed -i'.bak' 's/theme = .*/theme = "
						.. terminal_theme_dark
						.. "/' (readlink ~/.config/ghostty/config)"
				)
			end
		end
	end,
})
