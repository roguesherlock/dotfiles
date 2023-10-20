--  TODO: add dark mode detection
--
-- https://github.com/jascha030/macos-nvim-dark-mode
-- local os_is_dark = function()
-- 	return (vim.call(
-- 		"system",
-- 		[[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
-- 	)):find("dark") ~= nil
-- end

return {
	-- {
	-- 	"bluz71/vim-nightfly-guicolors",
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		-- load the colorscheme here
	-- 		-- vim.cmd([[colorscheme nightfly]])
	-- 	end,
	-- },
	-- {
	-- 	"mikesmithgh/gruvsquirrel.nvim",
	-- },
	-- gruvbox
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	config = function()
	-- 		require("gruvbox").setup({
	-- 			contrast = "soft",
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"sainnhe/gruvbox-material",
	-- },
	--
	-- {
	-- 	"ramojus/mellifluous.nvim",
	-- 	config = function()
	-- 		require("mellifluous").setup({ --[[...]]
	-- 		}) -- optional, see configuration section.
	-- 	end,
	-- },
	-- {
	-- 	"mcchrish/zenbones.nvim",
	-- 	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
	-- 	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
	-- 	-- In Vim, compat mode is turned on as Lush only works in Neovim.
	-- 	dependencies = { "rktjmp/lush.nvim" },
	-- },
	--
	-- everforest
	-- { "sainnhe/everforest" },
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
				background = "hard",
				italics = true,
				transparent_background_level = 2,
			})
		end,
	},

	-- nightfox
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	config = function()
	-- 		require("nightfox").setup({
	-- 			options = {
	-- 				transparent = true,
	-- 				styles = {
	-- 					comments = "italic",
	-- 					keywords = "bold",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- onedark
	-- {
	-- 	"navarasu/onedark.nvim",
	-- },

	-- github
	-- {
	-- 	"projekt0n/github-nvim-theme",
	-- 	-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	-- priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		require("github-theme").setup({
	-- 			options = {
	-- 				styles = {
	-- 					comments = "italic",
	-- 					keywords = "bold",
	-- 					types = "italic,bold",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- rose-pine
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	-- priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			-- highlight_groups = {
	-- 			-- 	IndentBlanklineChar = { fg = "highlight_low" },
	-- 			-- 	IndentBlanklineContextChar = { fg = "highlight_high" },
	-- 			-- 	IndentBlanklineContextStart = { sp = "highlight_high" },
	-- 			-- },
	-- 		})
	-- 	end,
	-- },

	-- kanagawa
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	overrides = function(colors)
	-- 		local theme = colors.theme
	-- 		return {
	-- 			IndentBlanklineChar = { fg = theme.ui.bg_p1 },
	-- 			IndentBlanklineContextChar = { fg = theme.ui.bg_p2 },
	-- 			IndentBlanklineContextStart = { sp = theme.ui.bg_p2 },
	-- 		}
	-- 	end,
	-- },
	-- Configure LazyVim to load colorscheme
	{
		"LazyVim/LazyVim",
		opts = function(_, opts)
			opts.colorscheme = "everforest"
			-- if os_is_dark() then
			-- 	vim.o.background = "dark"
			-- else
			-- 	vim.o.background = "light"
			-- end
			-- return opts
		end,
	},
}
