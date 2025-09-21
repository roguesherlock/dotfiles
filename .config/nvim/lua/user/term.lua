local M = {}

function M.list()
  local terms = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" and vim.fn.bufloaded(buf) == 1 then
      table.insert(terms, buf)
    end
  end
  return terms
end

function M.new(name)
  vim.cmd.terminal(vim.o.shell)
  vim.cmd("file term://" .. name)
  vim.api.nvim_set_option_value("buflisted", false, { buf = 0 })
  vim.api.nvim_set_option_value("modified", true, { buf = 0 })
  vim.cmd("startinsert")
end

local lastTerm = nil
function M.open()
  local buf = nil
  if lastTerm ~= nil and vim.fn.bufloaded(lastTerm) == 1 then
    buf = lastTerm
  else
    local terms = M.list()
    if #terms > 0 then
      buf = terms[1]
    end
  end
  if buf == nil then
    buf = vim.api.nvim_create_buf(false, true)
  end
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = vim.o.columns,
    height = vim.o.lines - vim.o.cmdheight,
    row = 0,
    col = 0,
    style = "minimal",
  })
  if vim.bo[buf].buftype ~= "terminal" then
    M.new("default")
  else
    vim.cmd("startinsert")
  end
  vim.api.nvim_set_option_value("winhighlight", "Normal:Normal", { win = win })
end

function M.go_to(n)
  local terms = M.list()
  if #terms == 1 then
    return
  end
  local cur = vim.api.nvim_get_current_buf()
  for i, buf in ipairs(terms) do
    if buf == cur then
      i = i + n
      if i == 0 then
        i = #terms
      elseif i > #terms then
        i = 1
      end
      vim.api.nvim_win_set_buf(0, terms[i])
      vim.cmd.startinsert()
      return
    end
  end
end

-- Checks if any process is running in termimals
-- If no process is running, returns false
-- If process is running, returns true
M.check_open_processes = function()
  -- check if any process is running in termimals
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" and vim.fn.bufloaded(buf) == 1 then
      local pid = vim.b[buf].terminal_job_pid
      local handle = io.popen("pgrep -P " .. pid)
      if handle ~= nil then
        local child_pids_string = handle:read("*a")
        handle:close()
        if #child_pids_string > 0 then
          vim.notify(vim.fn.bufname(buf) .. " has running process", vim.log.levels.ERROR)
          lastTerm = buf
          return true
        end
      end
    end
  end
  return false
end

M.setup = function()
  local map = require("user.util").map

  map({ "n", "t" }, "<c-/>", function()
    if vim.bo.buftype == "terminal" then
      lastTerm = vim.api.nvim_get_current_buf()
      vim.cmd("close")
    else
      M.open()
    end
  end, { desc = "toggle terminal" })

  map("t", "<c-n>", function()
    local name = vim.fn.input("name: ")
    if name ~= "" then
      M.new(name)
    end
  end, { desc = "create new terminal" })

  map("t", "<c-h>", function()
    M.go_to(-1)
  end, { desc = "go to prev terminal" })

  map("t", "<c-l>", function()
    M.go_to(1)
  end, { desc = "go to next terminal" })

  map("t", "<c-]>", "<c-\\><c-n>", { desc = "return to normal mode" })

  map("t", "<c-q>", function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("close")
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_delete(buf, {})
      vim.notify("term closed")
    end
  end, { desc = "quit terminal" })

  map("t", "<c-o>", function()
    local buffers = vim.fn.getbufinfo({ bufloaded = 1 })
    table.sort(buffers, function(a, b)
      return a.lastused > b.lastused
    end)
    local items = {}
    for _, bufinfo in ipairs(buffers) do
      if vim.bo[bufinfo.bufnr].buftype == "terminal" and vim.api.nvim_get_current_buf() ~= bufinfo.bufnr then
        table.insert(items, bufinfo)
      end
    end
    if #items == 0 then
      vim.api.nvim_echo({ { "no other terminals found" } }, false, {})
    elseif #items == 1 then
      vim.api.nvim_win_set_buf(0, items[1].bufnr)
      vim.cmd.startinsert()
    else
      vim.ui.select(items, {
        prompt = "Terminals:",
        format_item = function(item)
          return vim.fn.fnamemodify(item.name, ":t")
        end,
      }, function(item)
        if item ~= nil then
          vim.api.nvim_win_set_buf(0, item.bufnr)
        end
        vim.cmd.startinsert()
      end)
      vim.schedule(vim.cmd.startinsert)
    end
  end, { desc = "pick terminal" })

  vim.api.nvim_create_autocmd("TermClose", {
    desc = "explicity close terminal",
    group = vim.api.nvim_create_augroup("user-term", { clear = true }),
    callback = function(ctx)
      vim.cmd.stopinsert()
      map("n", "q", function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_delete(buf, {})
        vim.notify("term closed")
        M.go_to(1)
      end, { buffer = 0 })
      vim.api.nvim_create_autocmd("TermEnter", {
        desc = "prevent terminal mode",
        -- group = vim.api.nvim_create_augroup("user-term-prevent", { clear = true }),
        callback = function()
          vim.notify("term entered")
          vim.cmd.stopinsert()
        end,
        buffer = ctx.buf,
      })
    end,
    nested = true,
  })
end

return M
