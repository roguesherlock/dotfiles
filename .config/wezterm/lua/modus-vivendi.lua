-- Modus Vivendi
-- Copyright (c) 2023 miikanissi

-- repository: [Add repository URL here]
-- license: [Add license here]

local M = {}

local palette = {
	base = "#000000",
	foreground = "#ffffff",
	cursor_bg = "#ffffff",
	cursor_border = "#ffffff",
	cursor_fg = "#000000",
	selection_bg = "#7030af",
	selection_fg = "#ffffff",
	split = "#79a8ff",
	compose_cursor = "#fec43f",
}

local active_tab = {
	bg_color = "#000000",
	fg_color = "#c6daff",
}

local inactive_tab = {
	bg_color = "#545454",
	fg_color = "#ffffff",
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
			"#000000",
			"#ff5f59",
			"#44bc44",
			"#d0bc00",
			"#2fafff",
			"#feacd0",
			"#00d3d0",
			"#ffffff",
		},

		brights = {
			"#1e1e1e",
			"#ff5f5f",
			"#44df44",
			"#efef00",
			"#338fff",
			"#ff66ff",
			"#00eff0",
			"#989898",
		},

		tab_bar = {
			background = "#313131",
			active_tab = active_tab,
			inactive_tab = inactive_tab,
			inactive_tab_hover = {
				fg_color = "#c6daff",
				bg_color = "#545454",
			},
			new_tab_hover = {
				fg_color = "#c6daff",
				bg_color = "#000000",
			},
			new_tab = {
				fg_color = "#ffffff",
				bg_color = "#313131",
			},
			inactive_tab_edge = "#545454", -- (Fancy tab bar only)
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
