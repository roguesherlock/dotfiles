--  TODO: add dark mode detection
-- https://github.com/jascha030/macos-nvim-dark-mode
-- local os_is_dark = function()
-- 	return (vim.call(
-- 		"system",
-- 		[[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
-- 	)):find("dark") ~= nil
-- end

return {
	-- add gruvbox
	{
		"ellisonleao/gruvbox.nvim",
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
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

	-- Configure LazyVim to load gruvbox
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
