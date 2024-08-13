return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		{ "kevinhwang91/promise-async" },
	},
	config = function()
		local ufo = require("ufo")

		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		-- global handler
		-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
		-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
		ufo.setup({
			close_fold_kinds_for_ft = {
				default = { "imports", "comment" },
				json = { "array" },
				c = { "comment", "region" },
			},
			open_fold_hl_timeout = 0,
			provider_selector = function(_, filetype)
				return { "treesitter", "indent" }
			end,
			fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
				local _start = lnum - 1
				local _end = end_lnum - 1
				local start_text = vim.api.nvim_buf_get_text(0, _start, 0, _start, -1, {})[1]
				local final_text = vim.trim(vim.api.nvim_buf_get_text(0, _end, 0, _end, -1, {})[1])
				return start_text .. " ⋯ " .. final_text .. (" 󰁂 %d "):format(end_lnum - lnum)
			end,
		})

		vim.keymap.set("n", "zR", require("ufo").openAllFolds)
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
		vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
		vim.keymap.set("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				-- choose one of coc.nvim and nvim lsp
				-- vim.fn.CocActionAsync('definitionHover') -- coc.nvim
				vim.lsp.buf.hover()
			end
		end)
	end,
}
