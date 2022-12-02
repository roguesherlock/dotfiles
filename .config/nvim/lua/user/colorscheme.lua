local colorscheme = "onedark"
vim.g.tokyonight_style = "night"
vim.g.enfocado_style = "neon" -- Available: `nature` or `neon`.

-- onedark options
require("onedark").setup({
	-- Main options --
	style = "warmer", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = false, -- Show/hide background
	term_colors = true, -- Change terminal color as per the selected theme style
	ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

	-- toggle theme style ---
	toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
	toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

	-- Change code style ---
	-- Options are italic, bold, underline, none
	-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
	code_style = {
		comments = "italic",
		keywords = "none",
		functions = "none",
		strings = "none",
		variables = "none",
	},

	-- Lualine options --
	lualine = {
		transparent = false, -- lualine center bar transparency
	},

	-- Custom Highlights --
	colors = {}, -- Override default colors
	highlights = {}, -- Override highlight groups

	-- Plugins Config --
	diagnostics = {
		darker = true, -- darker colors for diagnostic
		undercurl = true, -- use undercurl instead of underline for diagnostics
		background = true, -- use background color for virtual text
	},
})

-- nightfox options
require("nightfox").setup({
	options = {
		-- Compiled file's destination location
		compile_path = vim.fn.stdpath("cache") .. "/nightfox",
		compile_file_suffix = "_compiled", -- Compiled file suffix
		transparent = true, -- Disable setting background
		terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
		dim_inactive = false, -- Non focused panes set to alternative background
		styles = { -- Style to be applied to different syntax groups
			comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
			conditionals = "NONE",
			constants = "NONE",
			functions = "NONE",
			keywords = "NONE",
			numbers = "NONE",
			operators = "NONE",
			strings = "NONE",
			types = "NONE",
			variables = "NONE",
		},
		inverse = { -- Inverse highlight for different types
			match_paren = false,
			visual = false,
			search = false,
		},
		modules = { -- List of various plugins and additional options
		},
	},
	palettes = {},
	specs = {},
	groups = {},
})

-- setup must be called before loading
--[[ vim.cmd("colorscheme terafox") ]]

--[[ local status, n = pcall(require, "neosolarized") ]]
--[[ if not status then ]]
--[[ 	return ]]
--[[ end ]]
--[[]]
--[[ n.setup({ ]]
--[[ 	comment_italics = true, ]]
--[[ }) ]]
--[[]]
--[[ local cb = require("colorbuddy.init") ]]
--[[ local Color = cb.Color ]]
--[[ local colors = cb.colors ]]
--[[ local Group = cb.Group ]]
--[[ local groups = cb.groups ]]
--[[ local styles = cb.styles ]]
--[[]]
--[[ Color.new("black", "#000000") ]]
--[[ Group.new("CursorLine", colors.none, colors.base03, styles.NONE, colors.base1) ]]
--[[ Group.new("CursorLineNr", colors.yellow, colors.black, styles.NONE, colors.base1) ]]
--[[ Group.new("Visual", colors.none, colors.base03, styles.reverse) ]]
--[[]]
--[[ local cError = groups.Error.fg ]]
--[[ local cInfo = groups.Information.fg ]]
--[[ local cWarn = groups.Warning.fg ]]
--[[ local cHint = groups.Hint.fg ]]
--[[]]
--[[ Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE) ]]
--[[ Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE) ]]
--[[ Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE) ]]
--[[ Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE) ]]
--[[ Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError) ]]
--[[ Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn) ]]
--[[ Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo) ]]
--[[ Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint) ]]

vim.g.catppuccin_flavour = "macchiato"

local colors = require("catppuccin.palettes").get_palette()
colors.none = "NONE"
require("catppuccin").setup({
	--[[ custom_highlights = { ]]
	--[[ 	Comment = { fg = colors.overlay1 }, ]]
	--[[ 	LineNr = { fg = colors.overlay1 }, ]]
	--[[ 	CursorLine = { bg = colors.overlay0 }, ]]
	--[[ 	CursorLineNr = { fg = colors.lavender, bg = colors.overlay1 }, ]]
	--[[ 	DiagnosticVirtualTextError = { bg = colors.none }, ]]
	--[[ 	DiagnosticVirtualTextWarn = { bg = colors.none }, ]]
	--[[ 	DiagnosticVirtualTextInfo = { bg = colors.none }, ]]
	--[[ 	DiagnosticVirtualTextHint = { bg = colors.none }, ]]
	--[[ }, ]]
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	transparent_background = false,
	term_colors = false,
	compile = {
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		coc_nvim = false,
		lsp_trouble = true,
		cmp = true,
		lsp_saga = false,
		gitgutter = false,
		gitsigns = true,
		leap = true,
		telescope = true,
		nvimtree = true,
		neotree = {
			enabled = false,
			show_root = true,
			transparent_panel = false,
		},
		dap = {
			enabled = true,
			enable_ui = true,
		},
		which_key = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		dashboard = true,
		neogit = false,
		vim_sneak = false,
		fern = false,
		barbar = false,
		bufferline = {
			enabled = true,
			italics = true,
			bolds = true,
		},
		markdown = true,
		lightspeed = false,
		ts_rainbow = false,
		hop = false,
		notify = true,
		telekasten = true,
		symbols_outline = true,
		mini = false,
		aerial = false,
		vimwiki = true,
		beacon = true,
		navic = false,
		overseer = false,
	},
	color_overrides = {},
	highlight_overrides = {},
})
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
