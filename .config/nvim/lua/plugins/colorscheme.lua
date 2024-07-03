return {
	-- {
	-- 	"bluz71/vim-nightfly-guicolors",
	-- 	lazy = true,
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		vim.g.nightflyVirtualTextColor = true
	-- 		vim.g.nightflyNormalFloat = true
	-- 		vim.g.nightflyflyCursorColor = true
	-- 		-- vim.g.nightflyTransparent = true
	-- 		-- load the colorscheme here
	-- 		-- vim.cmd([[colorscheme nightfly]])
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	opts = {
	-- 		transparent_background = true,
	-- 	},
	-- },
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.moonflyVirtualTextColor = true
			vim.g.moonflyNormalFloat = true
			vim.g.moonflyCursorColor = true
			vim.g.moonflyTransparent = true
		end,
	},
	-- { "kepano/flexoki-neovim", name = "flexoki", lazy = true, priority = 1000 },
	-- { "uloco/bluloco.nvim", lazy = false, priority = 1000 },
	-- {
	-- 	"mikesmithgh/gruvsquirrel.nvim",
	-- },
	-- gruvbox
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		-- transparent_mode = true,
	-- 	},
	-- 	-- config = function()
	-- 	-- 	require("gruvbox").setup({
	-- 	-- 		contrast = "soft",
	-- 	-- 	})
	-- 	-- end,
	-- },
	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	name = "gruvbox-material",
	-- 	lazy = true,
	-- 	priority = 1000,
	-- },
	{
		"sainnhe/gruvbox-material",
		name = "gruvbox-material",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_better_performance = 1
			-- Fonts
			vim.g.gruvbox_material_disable_italic_comment = 0
			vim.g.gruvbox_material_enable_italic = 0
			vim.g.gruvbox_material_enable_bold = 0
			vim.g.gruvbox_material_transparent_background = 1
			-- Themes
			vim.g.gruvbox_material_foreground = "mix"
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_ui_contrast = "high" -- The contrast of line numbers, indent lines, etc.
			vim.g.gruvbox_material_float_style = "dim" -- Background of floating windows

			-- vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
			-- vim.g.gruvbox_material_diagnostic_line_highlight = 1
			vim.g.gruvbox_material_current_word = "grey background"

			local configuration = vim.fn["gruvbox_material#get_configuration"]()
			local palette = vim.fn["gruvbox_material#get_palette"](
				configuration.background,
				configuration.foreground,
				configuration.colors_override
			)

			-- vim.cmd.colorscheme("gruvbox-material")

			local highlights_groups = {
				FoldColumn = { bg = "none" },
				SignColumn = { bg = "none" },
				Normal = { bg = "none" },
				NormalNC = { bg = "none" },
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none", fg = palette.orange[1] },
				TelescopeBorder = { bg = "none" },
				TelescopeNormal = { fg = "none" },
				TelescopePromptNormal = { bg = "none" },
				TelescopeResultsNormal = { bg = "none" },
				TelescopeSelection = { bg = palette.bg3[1] },
				Visual = { bg = palette.bg_visual_red[1] },
				Cursor = { bg = palette.bg_red[1], fg = palette.bg_dim[1] },
				ColorColumn = { bg = palette.bg_visual_blue[1] },
				CursorLine = { bg = palette.bg3[1], blend = 25 },
				GitSignsAdd = { fg = palette.green[1], bg = "none" },
				GitSignsChange = { fg = palette.yellow[1], bg = "none" },
				GitSignsDelete = { fg = palette.red[1], bg = "none" },
			}

			for group, styles in pairs(highlights_groups) do
				vim.api.nvim_set_hl(0, group, styles)
			end
		end,
	},

	{
		"ramojus/mellifluous.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			-- color_set = "mellifluous",
			color_set = "mountain",
			-- transparent_background = {
			-- 	enabled = true,
			-- 	floating_windows = true,
			-- 	telescope = true,
			-- 	file_tree = true,
			-- 	cursor_line = true,
			-- 	status_line = false,
			-- },
		},
	},
	{
		"savq/melange-nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"dasupradyumna/midnight.nvim",
		lazy = true,
		priority = 1000,
	},
	-- { "nyoom-engineering/oxocarbon.nvim" },
	{
		"mcchrish/zenbones.nvim",
		lazy = false,
		priority = 1000,
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			vim.g.zenbones = {
				-- transparent_background = true,
				lightness = "bright",
				darkness = "stark",
			}
			vim.g.zenwritten = {
				lightness = "bright",
				darkness = "warm",
				lighten_non_text = 25,
				lighten_comments = 28,
				-- transparent_background = true,
			}
		end,
	},
	--
	-- everforest
	-- {
	-- 	"sainnhe/everforest",
	-- 	config = function()
	-- 		vim.g.everforest_transparent_background = 2
	-- 	end,
	-- },
	{
		"neanias/everforest-nvim",
		lazy = true,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
				-- background = "hard",
				-- italics = true,
				transparent_background_level = 2,
			})
		end,
	},

	-- nightfox
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
					styles = {
						comments = "italic",
						keywords = "bold",
					},
				},
			})
		end,
	},

	-- onedark
	-- {
	-- 	"navarasu/onedark.nvim",
	-- },
	{
		"rockyzhang24/arctic.nvim",
		lazy = true,
		priority = 1000,
		branch = "v2",
		dependencies = { "rktjmp/lush.nvim" },
	},
	{
		"crispybaccoon/aki",
		lazy = true,
		priority = 1000,
	},
	{
		"crispybaccoon/evergarden",
		lazy = true,
		priority = 1000,
	},

	-- github
	{
		"projekt0n/github-nvim-theme",
		lazy = true,
		priority = 1000,
		config = function()
			require("github-theme").setup({
				-- options = {
				-- 	transparent = true,
				-- 	styles = {
				-- 		comments = "italic",
				-- 		keywords = "bold",
				-- 		types = "italic,bold",
				-- 	},
				-- },
			})
		end,
	},

	-- rose-pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		priority = 1000,
		opts = {
			styles = {
				transparency = true,
			},
		},
	},

	-- kanagawa
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 1000,
		-- opts = {
		-- 	-- transparent = true,
		-- 	overrides = function(colors)
		-- 		local theme = colors.theme
		-- 		return {
		-- 			-- NormalFloat = { bg = "none" },
		-- 			-- FloatBorder = { bg = "none" },
		-- 			-- FloatTitle = { bg = "none" },
		-- 			--
		-- 			-- -- Save an hlgroup with dark background and dimmed foreground
		-- 			-- -- so that you can use it where your still want darker windows.
		-- 			-- -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
		-- 			-- -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
		-- 			-- NormalDark = { fg = "none", bg = theme.ui.bg_m3 },
		-- 			--
		-- 			-- -- Popular plugins that open floats will link to NormalFloat by default;
		-- 			-- -- set their background accordingly if you wish to keep them dark and borderless
		-- 			-- -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
		-- 			-- -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
		-- 			-- LazyNormal = { bg = "none", fg = theme.ui.fg_dim },
		-- 			-- MasonNormal = { bg = "none", fg = theme.ui.fg_dim },
		--
		-- 			IndentBlanklineChar = { fg = theme.ui.bg_p1 },
		-- 			IndentBlanklineContextChar = { fg = theme.ui.bg_p2 },
		-- 			IndentBlanklineContextStart = { sp = theme.ui.bg_p2 },
		-- 		}
		-- 	end,
		-- },
	},
	{
		"miikanissi/modus-themes.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			-- variant = "tinted",
			-- variant = "tritanopia",
			-- variant = "deuteranopia",
		},
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	-- {
	-- 	"craftzdog/solarized-osaka.nvim",
	-- 	branch = "osaka",
	-- 	lazy = true,
	-- 	priority = 1000,
	-- 	opts = function()
	-- 		return {
	-- 			transparent = true,
	-- 		}
	-- 	end,
	-- },
	-- Configure LazyVim to load colorscheme
	-- {
	-- 	"LazyVim/LazyVim",
	-- 	opts = function(_, opts)
	-- 		opts.colorscheme = "melange"
	-- 		-- init()
	-- 	end,
	-- },
}
