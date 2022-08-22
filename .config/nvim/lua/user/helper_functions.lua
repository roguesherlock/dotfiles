function map(mode, shortcut, command, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, shortcut, command, options)
end



function tmap(shortcut, command, opts)
  map("t", shortcut, command, opts)
end

function nmap(shortcut, command, opts)
  map("n", shortcut, command, opts)
end

function imap(shortcut, command, opts)
  map("i", shortcut, command, opts)
end

function vmap(shortcut, command, opts)
  map("v", shortcut, command, opts)
end

function xmap(shortcut, command, opts)
  map("x", shortcut, command, opts)
end
