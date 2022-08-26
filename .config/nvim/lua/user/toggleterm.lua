local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
	},
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end


--[[ local fterm = require("FTerm") ]]
--[[ local fterm_status_ok, fterm = pcall(require, "FTerm") ]]
--[[ if not fterm_status_ok then ]]
--[[ 	return ]]
--[[ end ]]
--[[]]
--[[ fterm.setup() ]]
--[[]]
--[[ local gitui = fterm:new({ ]]
--[[     ft = 'fterm_gitui', -- You can also override the default filetype, if you want ]]
--[[     cmd = "gitui", ]]
--[[     dimensions = { ]]
--[[         height = 0.9, ]]
--[[         width = 0.9 ]]
--[[     } ]]
--[[ }) ]]
--[[]]
--[[ local lazygit = fterm:new({ ]]
--[[     ft = 'fterm_lazygit', -- You can also override the default filetype, if you want ]]
--[[     cmd = "lazygit", ]]
--[[     dimensions = { ]]
--[[         height = 0.9, ]]
--[[         width = 0.9 ]]
--[[     } ]]
--[[ }) ]]
--[[]]
--[[ function _LAZYGIT_TOGGLE() ]]
--[[    lazygit:toggle() ]]
--[[ end ]]

