-- everforest

local M = {}

local brights = {
	"#4d5960",
	"#e67e80",
	"#a7c080",
	"#dbbc7f",
	"#7fbbb3",
	"#d699b6",
	"#83c092",
	"#d3c6aa",
}

local active_tab = {
	-- bg_color = "#3D484D",
	bg_color = "#3D484D",
	-- fg_color = "#7A8478",
	fg_color = "#9DA9A0",
}

local inactive_tab = {
	bg_color = "#2D353B",
	fg_color = "#7A8478",
}

function M.colors()
	return {
		cursor_bg = "#d3c6aa",
		cursor_border = "#d3c6aa",
		cursor_fg = "#2D353B",
		foreground = "#d3c6aa",
		background = "#2D353B",
		selection_bg = "#5c3f4f",
		selection_fg = "#d3c6aa",

		ansi = brights,
		brights = brights,

		tab_bar = {
			background = "#2D353B",
			active_tab = active_tab,
			inactive_tab = inactive_tab,
			inactive_tab_hover = active_tab,
			new_tab = inactive_tab,
			new_tab_hover = active_tab,
			inactive_tab_edge = "#2D353B", -- (Fancy tab bar only)
		},
	}
end

function M.window_frame() -- (Fancy tab bar only)
	return {
		active_titlebar_bg = "#2D353B",
		inactive_titlebar_bg = "#2D353B",
	}
end

return M
