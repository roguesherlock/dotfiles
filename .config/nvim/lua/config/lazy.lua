local colorscheme = require("user.colorscheme")
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
				colorscheme = colorscheme.initialColorScheme,
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
			-- "mcchrish/zenbones.nvim",
			-- "rose-pine/neovim",
			-- "savq/melange-nvim",
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

colorscheme.init()
