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
-- Delete all buffers except the current one
map("n", "<leader>bD", "<cmd>bufdo bd<cr>", { desc = "[B]uffer [D]elete All" })
map("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Delete other buffers" })
map("n", "<leader>yp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  vim.notify("Copied path: " .. vim.fn.expand("%:p"))
end, { desc = "[Y]ank buffer [P]ath" })

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
map("n", "<leader>q", function()
  vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Open local buffer errors [Q]uickfix list" })
map("n", "<leader>Q", vim.diagnostic.setloclist, { desc = "Open local buffer diagnostics [Q]uickfix list" })
map("n", "<leader>d", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Open all buffer errors [D]iagnostic list" })
map("n", "<leader>D", vim.diagnostic.setqflist, { desc = "Open all buffer [D]iagnostics list" })

-- quickfix list
map("n", "<leader>xx", "<cmd>copen<cr>", { desc = "Open [X]Quikfi[X] list" })
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open [X]local [l]ist" })

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

--
-- Window management
--

-- NOTE: we use `w` keybind for window management
--  See `:help wincmd` for a list of all window commands
-- map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- map("n", "<leader>wv", "<C-w><C-v>", { desc = "Split [W]indow [V]ertically" })
-- map("n", "<leader>wq", "<C-w>q", { desc = "[W]indow [D]elete" })
-- map("n", "<leader>wo", "<C-w>o", { desc = "[W]indow [O]nly" })
-- Window maximization toggle
vim.g.maximized_win = nil
vim.opt.winminwidth = 12
local function toggle_window_maximize()
  local current_win = vim.api.nvim_get_current_win()

  -- If current window is already maximized, restore original layout
  if vim.g.maximized_win == current_win then
    vim.cmd("wincmd =") -- Equalize all windows
    vim.g.maximized_win = nil
  else
    -- Store current window ID and maximize it, but keep minimal width for others
    vim.g.maximized_win = current_win
    -- -- Set current window to large width, others to minimum
    -- local windows = vim.api.nvim_list_wins()
    -- for _, win in ipairs(windows) do
    --   if win ~= current_win and vim.api.nvim_win_is_valid(win) then
    --     vim.api.nvim_win_set_width(win, 12) -- Keep 3 columns visible for other windows
    --   end
    -- end
    -- -- Make current window take remaining space
    -- vim.cmd("vertical resize 999")
    vim.cmd("wincmd |")
  end
end

-- Auto-maximize window when switching to it if another window is maximized
local function auto_maximize_on_switch()
  if vim.g.maximized_win and vim.g.maximized_win ~= vim.api.nvim_get_current_win() then
    vim.g.maximized_win = vim.api.nvim_get_current_win()
    -- -- Set current window to large width, others to minimum
    -- local windows = vim.api.nvim_list_wins()
    -- for _, win in ipairs(windows) do
    --   if win ~= vim.g.maximized_win and vim.api.nvim_win_is_valid(win) then
    --     vim.api.nvim_win_set_width(win, 12) -- Keep 3 columns visible for other windows
    --   end
    -- end
    -- -- Make current window take remaining space
    -- vim.cmd("vertical resize 999")
    vim.cmd("wincmd |")
  end
end

-- stylua: ignore start
map("n", "wm", toggle_window_maximize, { desc = "[W]indow [M]aximize toggle" })
map("n", "wh", function() vim.cmd("wincmd h"); auto_maximize_on_switch() end, { desc = "Move focus to the left window (auto-maximize)" })
map("n", "wl", function() vim.cmd("wincmd l"); auto_maximize_on_switch() end, { desc = "Move focus to the right window (auto-maximize)" })
map("n", "wj", function() vim.cmd("wincmd j"); auto_maximize_on_switch() end, { desc = "Move focus to the lower window (auto-maximize)" })
map("n", "wk", function() vim.cmd("wincmd k"); auto_maximize_on_switch() end, { desc = "Move focus to the upper window (auto-maximize)" })
map("n", "<C-h>", function() vim.cmd("wincmd h"); auto_maximize_on_switch() end, { desc = "Move focus to the left window (auto-maximize)" })
map("n", "<C-l>", function() vim.cmd("wincmd l"); auto_maximize_on_switch() end, { desc = "Move focus to the right window (auto-maximize)" })
map("n", "<C-j>", function() vim.cmd("wincmd j"); auto_maximize_on_switch() end, { desc = "Move focus to the lower window (auto-maximize)" })
map("n", "<C-k>", function() vim.cmd("wincmd k"); auto_maximize_on_switch() end, { desc = "Move focus to the upper window (auto-maximize)" })
-- stylua: ignore end

-- Reset window maximization state when maximized window is closed
vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    if vim.g.maximized_win then
      local win_exists = false
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if win == vim.g.maximized_win then
          win_exists = true
          break
        end
      end
      if not win_exists then
        vim.g.maximized_win = nil
      end
    end
  end,
})

---
--- End Window management
---

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
