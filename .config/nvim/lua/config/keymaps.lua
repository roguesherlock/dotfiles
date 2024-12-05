-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  opts.silent = opts.silent == nil and true or opts.silent
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<D-s>", ":w<CR>", { desc = "Save file" })
map("n", "<esc><esc>", ":w<CR>", { desc = "Save file" })

map({ "n", "v" }, "<leader>e", function()
  local MiniFiles = require("mini.files")
  if not MiniFiles.close() then
    local is_buffer_a_file = (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "")
    if is_buffer_a_file then
      MiniFiles.open(vim.api.nvim_buf_get_name(0))
    else
      MiniFiles.open()
    end
  end
end, { desc = "Toggle file [E]xplorer" })

map("n", ",", "za", { desc = "Toggle fold" })

map("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "[T]oggle [W]rap" })

map("n", "E", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- TODO: Figure out why the fuck does lazyvim override my keymaps
-- vim.schedule(function()
--   map("n", "<leader>ff", "<cmd>FzfLua git_files<cr>", {
--     desc = "Find Files (git_files)",
--     noremap = true,
--     silent = true,
--     buffer = -1, -- Apply to all buffers
--   })
-- end)
