-- Modus Operandi
-- Copyright (c) 2023 miikanissi

-- repository: [Add repository URL here]
-- license: [Add license here]

local M = {}

local palette = {
	base = "#ffffff",
	foreground = "#000000",
	cursor_bg = "#000000",
	cursor_border = "#000000",
	cursor_fg = "#ffffff",
	selection_bg = "#dfa0f0",
	selection_fg = "#000000",
	split = "#3548cf",
	compose_cursor = "#884900",
}

local active_tab = {
	bg_color = "#ffffff",
	fg_color = "#193668",
}

local inactive_tab = {
	bg_color = "#c2c2c2",
	fg_color = "#000000",
}

function M.colors()
	return {
		foreground = palette.foreground,
		background = palette.base,
		cursor_bg = palette.cursor_bg,
		cursor_border = palette.cursor_border,
		cursor_fg = palette.cursor_fg,
		selection_bg = palette.selection_bg,
		selection_fg = palette.selection_fg,
		split = palette.split,
		compose_cursor = palette.compose_cursor,

		ansi = {
			"#ffffff",
			"#a60000",
			"#006800",
			"#6f5500",
			"#0031a9",
			"#721045",
			"#005e8b",
			"#000000",
		},

		brights = {
			"#f2f2f2",
			"#d00000",
			"#008900",
			"#808000",
			"#0000ff",
			"#dd22dd",
			"#008899",
			"#595959",
		},

		tab_bar = {
			background = "#dfdfdf",
			active_tab = active_tab,
			inactive_tab = inactive_tab,
			inactive_tab_hover = {
				fg_color = "#193668",
				bg_color = "#c2c2c2",
			},
			new_tab_hover = {
				fg_color = "#193668",
				bg_color = "#ffffff",
			},
			new_tab = {
				fg_color = "#000000",
				bg_color = "#dfdfdf",
			},
			inactive_tab_edge = "#c2c2c2", -- (Fancy tab bar only)
		},
	}
end

function M.window_frame() -- (Fancy tab bar only)
	return {
		active_titlebar_bg = palette.base,
		inactive_titlebar_bg = palette.base,
	}
end

return M
