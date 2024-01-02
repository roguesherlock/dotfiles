local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

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
			"miikanissi/modus-themes.nvim",
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

-- TODO: auto switch theme to light/dark based on macos appearance
-- https://github.com/jascha030/macos-nvim-dark-mode
local os_is_dark = function()
	return (vim.fn.system(
		[[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
	)):find("dark") ~= nil
end

local set_from_os = function()
	if os_is_dark() then
		vim.o.background = "dark"
	else
		vim.o.background = "light"
	end
	vim.cmd.colorscheme("modus")
end

local init = function()
	vim.api.nvim_create_autocmd("Signal", {
		pattern = "*",
		callback = function()
			set_from_os()
		end,
	})
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			-- local colorscheme = string.lower(vim.g.colors_name).gmatch
			local colorscheme = string.match(vim.g.colors_name, "([^%-]+)")
			-- vim.print("colorscheme: " .. colorscheme)
			if vim.o.background == "light" then
				local theme = colorscheme .. "_light"
				vim.fn.system("kitty +kitten themes " .. theme)
			elseif vim.o.background == "dark" then
				local theme = colorscheme .. "_dark"
				vim.fn.system("kitty +kitten themes " .. theme)
			else
				vim.fn.system("kitty +kitten themes modus_dark")
			end
		end,
	})
	set_from_os()
end

init()
