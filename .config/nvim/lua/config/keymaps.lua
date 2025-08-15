local map = require("user.util").map

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- restart nvim
map("n", "<leader>R", "<cmd>restart<cr>", { desc = "Restart Nvim" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- buffers
map("n", "<S-h>", "<cmd>e #<cr>", { desc = "Other Buffer" })
map("n", "<S-l>", "<cmd>e #<cr>", { desc = "Other Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev [B]uffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next [B]uffer" })
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "[B]uffer [N]ew" })

map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "[T]ab [N]ew" })
map("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "[T]ab [Q]uit" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "[T]ab [O]nly" })
map("n", "<leader>tt", "<cmd>tablast<cr>", { desc = "[T]ab [L]ast" })
-- go to tab at index 1..9
for i = 1, 9 do
  map("n", "<leader>" .. i, function()
    vim.cmd.tabn(i)
  end, { desc = "Go to tab " .. i })
end

--keywordprg
-- See `:help 'keywordprg'`
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- quickfix list
map("n", "<leader>xx", "<cmd>copen<cr>", { desc = "Open [X]Quikfi[X] list" })
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open [L]ocal [X]Quikfi[X] list" })

-- quit
local function quit_with_prompt()
  local modified_buffers = {}
  for _, buf in ipairs(vim.fn.getbufinfo({ bufmodified = 1 })) do
    if buf.changed == 1 then
      table.insert(modified_buffers, buf)
    end
  end

  if #modified_buffers == 0 then
    vim.cmd("qa")
    return
  end

  for _, buf in ipairs(modified_buffers) do
    local choice = vim.fn.confirm("Save changes to " .. buf.name .. "?", "&Yes\n&No\n&Cancel", 1)
    if choice == 1 then -- Yes
      vim.api.nvim_buf_call(buf.bufnr, function()
        vim.cmd("write")
      end)
    elseif choice == 2 then -- No
      vim.cmd("qa!")
      -- Do nothing, continue to next buffer
    else -- Cancel or any other input
      return -- Stop the quit process
    end
  end

  vim.cmd("qa")
end
map("n", "<leader>wq", quit_with_prompt, { desc = "[W]orkspace [Q]uit All" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- NOTE: we use `w` keybind for window management
--  See `:help wincmd` for a list of all window commands
-- map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- map("n", "<leader>wv", "<C-w><C-v>", { desc = "Split [W]indow [V]ertically" })
-- map("n", "<leader>wq", "<C-w>q", { desc = "[W]indow [D]elete" })
-- map("n", "<leader>wo", "<C-w>o", { desc = "[W]indow [O]nly" })
map("n", "wm", "<C-w>|", { desc = "[W]indow [M]aximize" })

-- Save
map("n", "<D-s>", ":w<CR>", { desc = "Save file" })
map("n", "<esc><esc>", ":w<CR>", { desc = "Save file" })

map("n", "J", "mzJ`z", { desc = "Delete line and join with next line" })

-- cursor should stay centered while scrolling through results
map("n", "n", "nzzzv", { desc = "Move to next search result and keep window centered" })
map("n", "N", "Nzzzv", { desc = "Move to previous search result and keep window centered" })

-- Move lines
map("n", "<a-j>", ":m .+1<cr>==", { desc = "Move line down" })
map("n", "<a-k>", ":m .-2<cr>==", { desc = "Move line up" })

map("v", "<a-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "<a-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Highlight matches with +
map("n", "+", "*N", { desc = "Highlight all matches" })

-- Use <c-g> to change ocurrences of a word/selection one by one
map("n", "<c-g>", "*`'cgn", { desc = "Change next ocurrence" })
map("v", "<c-g>", "y<cmd>let @/=escape(@\", '/')<cr>\"_cgn", { desc = "Change next ocurrence (visual)" })

-- Block indentation (easier)
map("n", ">", ">>", { desc = "Indent right" })
map("n", "<", "<<", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent selection right" })
map("v", "<", "<gv", { desc = "Indent selection left" })

-- paste without overwriting register
map("v", "p", '"_dP')

-- Fold --
map("n", ",", "za", { desc = "Toggle fold" })

-- Resize --
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Toggle wrap
map("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "[T]oggle [W]rap" })

map("n", "E", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

map("n", "<leader>cx", ":.lua<CR>", { desc = "[C]ode E[x]ecute lua" })
map("v", "<leader>cx", ":lua =<CR>", { desc = "[C]ode E[x]ecute lua" })

map("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "[L]oad [L]azy" })
map("n", "<leader>lm", "<cmd>Mason<CR>", { desc = "[L]oad [M]ason" })

map("n", "<leader>tt", function()
  local colorscheme = require("user.colorscheme")
  if vim.o.background == "light" then
    colorscheme.set_colorscheme(false)
  else
    colorscheme.set_colorscheme(true)
  end
end, { desc = "[T]oggle [T]heme" })
