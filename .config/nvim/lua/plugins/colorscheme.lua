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
	-- gruvbox
	{
		"ellisonleao/gruvbox.nvim",
	},

	--nightfox
	{ "EdenEast/nightfox.nvim" },

	-- github
	{
		"projekt0n/github-nvim-theme",
		-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other start plugins
		-- config = function()
		-- 	require("github-theme").setup({
		-- 		-- ...
		-- 	})
		-- end,
	},

	-- rose-pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("rose-pine").setup({
				highlight_groups = {
					IndentBlanklineChar = { fg = "highlight_low" },
					IndentBlanklineContextChar = { fg = "highlight_high" },
					IndentBlanklineContextStart = { sp = "highlight_high" },
				},
			})
		end,
	},

	-- kanagawa
	{
		"rebelot/kanagawa.nvim",
		overrides = function(colors)
			local theme = colors.theme
			return {
				IndentBlanklineChar = { fg = theme.ui.bg_p1 },
				IndentBlanklineContextChar = { fg = theme.ui.bg_p2 },
				IndentBlanklineContextStart = { sp = theme.ui.bg_p2 },
			}
		end,
	},

	-- Configure LazyVim to load colorscheme
	{
		"LazyVim/LazyVim",
		opts = function(_, opts)
			opts.colorscheme = "rose-pine"
			-- if os_is_dark() then
			-- 	vim.o.background = "dark"
			-- else
			-- 	vim.o.background = "light"
			-- end
			-- return opts
		end,
	},
}
