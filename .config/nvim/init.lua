-- # vim:fileencoding=utf-8:ft=lua:foldmethod=indent
-- Enable Neovim's built-in loader
vim.loader.enable()

-- TODO:
-- 1. incremental seelction for treesitter
-- 2. included file not showing up in codecompanion chat
-- 3. ability to toggle diagnostics
-- 4. lazygit breaks if path name contains brackets
-- 5. trigger nvim with <c-space>

local add, now, later -- mini.deps will be setup later
-- colors, look at colors()
local light_theme, dark_theme
local enable_auto_switch = true
local default_light = false
local ghostty_light_theme = 'modus_light'
local ghostty_dark_theme = 'modus_dark'
local ghostty_custom_theme = true
local kitty_light_theme = 'modus_light'
local kitty_dark_theme = 'modus_dark'
local zellij_light_theme = 'modus_light'
local zellij_dark_theme = 'modus_dark'

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  opts.silent = opts.silent == nil and true or opts.silent
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function setup_options()
  -- [[ Setting options ]]
  -- See `:help vim.opt`
  -- NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

  -- Make line numbers default
  vim.opt.number = true
  -- You can also add relative line numbers, to help with jumping.
  --  Experiment for yourself to see if you like it!
  vim.opt.relativenumber = true

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.opt.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  vim.opt.showmode = false

  -- Enable break indent
  vim.opt.breakindent = true

  -- Save undo history
  vim.opt.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  -- Keep signcolumn on by default
  vim.opt.signcolumn = 'yes'

  -- Decrease update time
  vim.opt.updatetime = 250

  -- Decrease mapped sequence wait time
  -- Displays which-key popup sooner
  vim.opt.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.opt.splitright = true
  vim.opt.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  vim.opt.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.opt.inccommand = 'split'

  -- Show which line your cursor is on
  vim.opt.cursorline = true

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.opt.scrolloff = 10

  vim.opt.iskeyword:append '-'
  vim.opt.path:append '**'
  vim.opt.wildmenu = true
  vim.opt.wildignore:append '**/node_modules/**,**/dist/**'

  vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard
  vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
  end)
end

local function setup_mappings()
  vim.g.mapleader = ','
  vim.g.maplocalleader = '\\'

  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- better up/down
  map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
  map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
  map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
  map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

  -- buffers
  map('n', '<S-h>', '<cmd>e #<cr>', { desc = 'Other Buffer' })
  map('n', '<S-l>', '<cmd>e #<cr>', { desc = 'Other Buffer' })
  map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev [B]uffer' })
  map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next [B]uffer' })
  map('n', '<leader>bd', '<cmd>bd<cr>', { desc = '[B]uffer [D]elete with Window' })
  map('n', '<leader>bn', '<cmd>enew<cr>', { desc = '[B]uffer [N]ew' })

  --keywordprg
  -- See `:help 'keywordprg'`
  map('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  map('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic keymaps
  map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- quickfix list
  map('n', '<leader>xx', '<cmd>copen<cr>', { desc = 'Open [X]Quikfi[X] list' })
  map('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Open [L]ocal [X]Quikfi[X] list' })
  -- quit
  local function quit_with_prompt()
    local modified_buffers = {}
    for _, buf in ipairs(vim.fn.getbufinfo { bufmodified = 1 }) do
      if buf.changed == 1 then
        table.insert(modified_buffers, buf)
      end
    end

    if #modified_buffers == 0 then
      vim.cmd 'qa'
      return
    end

    for _, buf in ipairs(modified_buffers) do
      local choice = vim.fn.confirm('Save changes to ' .. buf.name .. '?', '&Yes\n&No\n&Cancel', 1)
      if choice == 1 then -- Yes
        vim.api.nvim_buf_call(buf.bufnr, function()
          vim.cmd 'write'
        end)
      elseif choice == 2 then -- No
        vim.cmd 'qa!'
        -- Do nothing, continue to next buffer
      else -- Cancel or any other input
        return -- Stop the quit process
      end
    end

    vim.cmd 'qa'
  end
  map('n', '<leader>wq', quit_with_prompt, { desc = '[W]orkspace [Q]uit All' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  --  See `:help wincmd` for a list of all window commands
  map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- Save
  map('n', '<D-s>', ':w<CR>', { desc = 'Save file' })
  map('n', '<esc><esc>', ':w<CR>', { desc = 'Save file' })

  map('n', 'J', 'mzJ`z', { desc = 'Delete line and join with next line' })

  -- cursor should stay centered while scrolling through results
  map('n', 'n', 'nzzzv', { desc = 'Move to next search result and keep window centered' })
  map('n', 'N', 'Nzzzv', { desc = 'Move to previous search result and keep window centered' })

  -- Move lines
  map('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'Move line down' })
  map('v', 'K', ":m '<-2<cr>gv=gv", { desc = 'Move line up' })

  -- Highlight matches with +
  map('n', '+', '*N', { desc = 'Highlight all matches' })

  -- Use <c-g> to change ocurrences of a word/selection one by one
  map('n', '<c-g>', "*`'cgn", { desc = 'Change next ocurrence' })
  map('v', '<c-g>', 'y<cmd>let @/=escape(@", \'/\')<cr>"_cgn', { desc = 'Change next ocurrence (visual)' })

  -- Block indentation (easier)
  map('n', '>', '>>', { desc = 'Indent right' })
  map('n', '<', '<<', { desc = 'Indent left' })
  map('v', '>', '>gv', { desc = 'Indent selection right' })
  map('v', '<', '<gv', { desc = 'Indent selection left' })

  -- paste without overwriting register
  map('v', 'p', '"_dP')

  -- Fold --
  map('n', '<space>', 'za', { desc = 'Toggle fold' })

  -- Resize --
  map('n', '<A-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
  map('n', '<A-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
  map('n', '<A-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
  map('n', '<A-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

  -- [[ Command Link Keymaps ]]
  -- map('c', '<C-j>', '<Down>', { desc = 'Next command' })
  -- map('c', '<C-k>', '<Up>', { desc = 'Previous command' })

  -- Toggle wrap
  map('n', '<leader>tw', '<cmd>set wrap!<cr>', { desc = '[T]oggle [W]rap' })
end

local function setup_autocommands()
  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.highlight.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('user-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- [[ Autosave ]] --
  vim.api.nvim_create_autocmd({
    'FocusLost',
    'BufEnter',
    'BufLeave',
  }, {
    pattern = {
      '*',
    },
    callback = function()
      if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype == '' then
        vim.api.nvim_command 'silent! update'
      end
    end,
  })

  -- Close certain filetypes with 'q'
  vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter' }, {
    pattern = {
      'qf', -- quickfix list
      'help', -- help files
      'man', -- man pages
      'notify', -- notifications
      'lspinfo', -- lsp info
      'spectre_panel',
      'startuptime',
      'tsplayground',
      'PlenaryTestPopup',
      'mini.pick', -- mini.pick
      'gitsigns*', -- gitsigns diff buffers
      'grug-far',
      'grug-far-history',
      'grug-far-help',
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
  })
end

local function setup_plugin_manager()
  local path_package = vim.fn.stdpath 'data' .. '/site/'
  local mini_path = path_package .. 'pack/deps/start/mini.nvim'
  if not vim.loop.fs_stat(mini_path) then
    vim.api.nvim_command 'echo "Installing `mini.nvim`" | redraw'
    local clone_cmd = {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/echasnovski/mini.nvim',
      mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.api.nvim_command 'packadd mini.nvim | helptags ALL'
    vim.api.nvim_command 'echo "Installed `mini.nvim`" | redraw'
  end
  require('mini.deps').setup { path = { package = path_package } }
  add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
end

-- TODO: auto switch theme to light/dark based on macos appearance
-- https://github.com/jascha030/macos-nvim-dark-mode
local os_is_dark = function()
  return (vim.fn.system [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]):find 'dark' ~= nil
end

---@param light boolean
local set_colorscheme = function(light)
  if light then
    vim.opt.background = 'light'
    vim.cmd('colorscheme ' .. light_theme)
  else
    vim.opt.background = 'dark'
    vim.cmd('colorscheme ' .. dark_theme)
  end
end

local set_from_os = function()
  if not enable_auto_switch then
    set_colorscheme(default_light)
  end
  if os_is_dark() then
    set_colorscheme(false)
  else
    set_colorscheme(true)
  end
end

local function switch_theme(theme)
  local theme_name, theme_type = theme:match '([^_]*)_([^_]*)'
  if theme_type == 'light' then
    theme_type = 'dark'
  else
    theme_type = 'light'
  end
  return theme_name .. '_' .. theme_type
end

local function set_ghostty_theme(theme, is_custom_theme)
  is_custom_theme = is_custom_theme or false
  if not is_custom_theme then
    -- vim.fn.system("sed -i'.bak' 's/theme = .*/theme = " .. ghostty_light_theme .. "/' (readlink ~/.config/ghostty/config)")
    local config_path = vim.fn.expand '~/.config/ghostty/config'
    local real_path = vim.fn.resolve(config_path)
    local cmd = string.format("sed -i'.bak' 's/theme = .*/theme = %s/' %s", theme, real_path)
    local result = vim.fn.system { 'bash', '-c', cmd }
    if vim.v.shell_error ~= 0 then
      print('Error updating Ghostty theme: ' .. result)
    end
    return
  end
  local base_config_path = vim.fn.expand '~/.config/ghostty/config'
  local theme_file_path = vim.fn.expand('~/.config/ghostty/' .. theme .. '.conf')

  -- Check if the theme file exists
  if vim.fn.filereadable(theme_file_path) == 0 then
    print('Theme file not found: ' .. theme_file_path)
    return
  end

  local currentTheme = switch_theme(theme)

  -- Read the content of the theme file
  local theme_content = vim.fn.readfile(theme_file_path)

  -- Read the current content of the base config file
  local base_config_content = vim.fn.readfile(base_config_path)

  -- Find the start and end indices of the current theme section
  local start_index, end_index
  local in_theme_section = false
  for i, line in ipairs(base_config_content) do
    if line:match('^# %s*' .. theme .. '$') then
      return
    elseif line:match('^# %s*' .. currentTheme .. '$') then
      start_index = i
      in_theme_section = true
    elseif line:match '^# End*$' and in_theme_section then
      end_index = i
      break
    end
  end

  -- Remove the current theme section if found
  if start_index and end_index then
    for i = end_index, start_index, -1 do
      table.remove(base_config_content, i)
    end
  end

  -- Insert the new theme content at the position where the old theme was removed
  -- or at the end if no theme section was found
  local insert_position = start_index or (#base_config_content + 1)
  for i, line in ipairs(theme_content) do
    table.insert(base_config_content, insert_position, line)
    insert_position = insert_position + 1
  end

  -- Write the updated content back to the base config file
  vim.fn.writefile(base_config_content, base_config_path)

  -- print("Theme set to: " .. theme)
end

local function tokyonight()
  add 'folke/tokyonight.nvim'

  local set_theme = function()
    dark_theme = 'tokyonight-night'
    light_theme = 'tokyonight-day'
    ghostty_dark_theme = 'tokyonight-night'
    ghostty_light_theme = 'tokyonight-day'
    ghostty_custom_theme = false
    kitty_dark_theme = 'Tokyo Night'
    kitty_light_theme = 'Tokyo Night Day'
    set_from_os()
  end

  require('tokyonight').setup {
    transparent = true,
  }

  vim.api.nvim_create_user_command('Tokyonight', set_theme, { desc = 'Set tokyonight theme' })
end

local function rosepine()
  add 'rose-pine/neovim'

  require('rose-pine').setup {
    styles = {
      transparency = true,
    },
  }

  local set_theme = function()
    dark_theme = 'rose-pine'
    light_theme = 'rose-pine'
    ghostty_dark_theme = 'rose-pine'
    ghostty_light_theme = 'rose-pine-dawn'
    ghostty_custom_theme = false
    kitty_dark_theme = 'Rosé Pine'
    kitty_light_theme = 'Rosé Pine Dawn'
    set_from_os()
  end

  vim.api.nvim_create_user_command('RosePine', set_theme, { desc = 'Set rosepine theme' })
end

local function modus()
  add 'miikanissi/modus-themes.nvim'

  local set_theme = function()
    dark_theme = 'modus_vivendi'
    light_theme = 'modus_operandi'
    -- ghostty_dark_theme = 'modus_dark'
    -- ghostty_light_theme = 'modus_light'
    -- ghostty_custom_theme = true
    ghostty_dark_theme = 'Builtin Pastel Dark'
    ghostty_light_theme = 'Builtin Tango Light'
    ghostty_custom_theme = false
    kitty_dark_theme = 'modus_dark'
    kitty_light_theme = 'modus_light'

    set_from_os()
  end
  require('modus-themes').setup {
    transparent = true,
    on_highlights = function(h, c)
      h.LeapLabel = { fg = c.fg_main, bg = c.bg_yellow_intense }
    end,
  }

  vim.api.nvim_create_user_command('Modus', set_theme, { desc = 'Set modus theme' })
end

local function catppuccin()
  add 'catppuccin/nvim'

  require('catppuccin').setup {
    transparent_background = true,
    term_colors = true,
    integrations = {
      cmp = true,
      dashboard = true,
      diffview = true,
      grug_far = true,
      gitsigns = true,
      headlines = true,
      harpoon = true,
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = {
        enabled = true,
        indentscope_color = '', -- catppuccin color (eg. `lavender`) Default: text
      },
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
          ok = { 'undercurl' },
        },
      },
      noice = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
      overseer = true,
    },
  }

  local set_theme = function()
    dark_theme = 'catppuccin'
    light_theme = 'catppuccin'
    ghostty_dark_theme = 'catppuccin-mocha'
    ghostty_light_theme = 'catppuccin-latte'
    ghostty_custom_theme = false
    kitty_dark_theme = 'catppuccin_dark'
    kitty_light_theme = 'catppuccin_light'
    set_from_os()
  end

  vim.api.nvim_create_user_command('Catppuccin', set_theme, { desc = 'Set catppuccin theme' })
end

local function melange()
  add 'savq/melange-nvim'

  local set_theme = function()
    dark_theme = 'melange'
    light_theme = 'melange'
    ghostty_dark_theme = 'Belafonte Night'
    ghostty_light_theme = 'Belafonte Day'
    ghostty_custom_theme = false
    kitty_dark_theme = 'melange_dark'
    kitty_light_theme = 'melange_light'
    set_from_os()
  end

  vim.api.nvim_create_user_command('Melange', set_theme, { desc = 'Set melange theme' })
end

local function everforest()
  add 'neanias/everforest-nvim'

  require('everforest').setup {
    on_highlights = function(h, c)
      h.LeapLabel = { fg = c.fg, bg = c.bg_red }
      h.LspReferenceRead = { bg = c.bg_visual }
      h.LspReferenceWrite = { bg = c.bg_visual }
      h.LspReferenceText = { bg = c.bg_visual }
    end,
  }

  local set_theme = function()
    dark_theme = 'everforest'
    light_theme = 'everforest'
    ghostty_dark_theme = 'GruvboxDark'
    ghostty_light_theme = 'GruvboxLight'
    ghostty_custom_theme = false
    kitty_dark_theme = 'Everforest Dark Medium'
    kitty_light_theme = 'Everforest Light Medium'
    set_from_os()
  end

  vim.api.nvim_create_user_command('Everforest', set_theme, { desc = 'Set everforest theme' })
end

local function custom_theme()
  -- add 'echasnovski/mini.colors'
  add 'echasnovski/mini.base16'

  require('mini.base16').setup {
    palette = {
      base00 = '#282828',
      base01 = '#3c3836',
      base02 = '#423e3c',
      base03 = '#484442',
      base04 = '#bdae93',
      base05 = '#d5c4a1',
      base06 = '#ebdbb2',
      base07 = '#fbf1c7',
      base08 = '#fb4934',
      base09 = '#fe8019',
      base0A = '#fabd2f',
      base0B = '#b8bb26',
      base0C = '#8ec07c',
      base0D = '#83a598',
      base0E = '#d3869b',
      base0F = '#d65d0e',
    },
  }

  -- add 'echasnovski/mini.hues'
  -- require('mini.hues').setup {
  --   -- Use config table as you like
  --   -- Needs both `background` and `foreground` fields present
  --   background = '#11262d',
  --   foreground = '#c0c8cc',
  -- }
end

local function colors()
  vim.opt.background = 'dark'
  modus()
  catppuccin()
  rosepine()
  -- tokyonight()
  -- melange()
  -- custom_theme()
  everforest()

  -- add 'sho-87/kanagawa-paper.nvim'
  -- add 'Mofiqul/vscode.nvim'
  -- add 'slugbyte/lackluster.nvim'
  -- add 'ribru17/bamboo.nvim'

  local term = os.getenv 'TERM'
  vim.api.nvim_create_autocmd('Signal', {
    pattern = '*',
    callback = function()
      set_from_os()
    end,
  })

  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
      if vim.o.background == 'light' then
        if term == 'xterm-kitty' then
          vim.fn.system('kitty +kitten themes ' .. kitty_light_theme)
        elseif term == 'xterm-ghostty' then
          set_ghostty_theme(ghostty_light_theme, ghostty_custom_theme)
        end
      elseif vim.o.background == 'dark' then
        if term == 'xterm-kitty' then
          vim.fn.system('kitty +kitten themes ' .. kitty_dark_theme)
        elseif term == 'xterm-ghostty' then
          set_ghostty_theme(ghostty_dark_theme, ghostty_custom_theme)
        end
      else
        if term == 'xterm-kitty' then
          vim.fn.system('kitty +kitten themes ' .. kitty_dark_theme)
        elseif term == 'xterm-ghostty' then
          set_ghostty_theme(ghostty_dark_theme, ghostty_custom_theme)
        end
      end
    end,
  })

  vim.api.nvim_create_user_command('Light', function()
    set_colorscheme(true)
  end, {})
  vim.api.nvim_create_user_command('Dark', function()
    set_colorscheme(false)
  end, {})

  vim.api.nvim_command 'Everforest'
  -- set_from_os()
end

local function plenary()
  add 'nvim-lua/plenary.nvim' -- necessary for lots of plugins
end

-- Load these plugins first
local function setup_priority_plugins()
  colors()
  plenary()
end

local function plugins_that_should_be_the_default()
  add 'tpope/vim-sleuth'
  add 'tpope/vim-repeat'
  add 'Bilal2453/luvit-meta'
end

local function which_key()
  add 'folke/which-key.nvim'
  vim.opt.timeout = true
  vim.opt.timeoutlen = 300
  require('which-key').setup {
    preset = 'helix',
    -- Document existing key chains
    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>b', group = '[B]uffer' },
      { '<leader>g', group = '[G]it' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>wt', group = '[W]orkspace [T]asks' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>l', group = '[L]SP' },
      { '<leader>gh', group = '[G]it [H]unk', mode = { 'n', 'v' } },
      { '<leader>a', group = '[A]i', mode = { 'n', 'v' } },
    },
  }
end

local function supermaven()
  add 'supermaven-inc/supermaven-nvim'
  require('supermaven-nvim').setup { log_level = 'off' }
  -- Trigger completion with <tab> manually since mini.completion doesn't play well with supermaven
  map('i', '<tab>', function()
    local suggestion = require 'supermaven-nvim.completion_preview'
    if suggestion.has_suggestion() then
      suggestion.on_accept_suggestion()
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<tab>', true, false, true), 'n', true)
    end
  end, { desc = 'Accept Supermaven suggestion' })
end

local function codecompanion()
  add 'olimorris/codecompanion.nvim'

  require('codecompanion').setup {
    strategies = {
      chat = {
        adapter = 'anthropic',
        slash_commands = {
          ['buffer'] = {
            opts = {
              provider = 'mini_pick',
            },
          },
          ['fetch'] = {
            opts = {
              provider = 'mini_pick',
            },
          },
          ['file'] = {
            opts = {
              provider = 'mini_pick',
            },
          },
          ['help'] = {
            opts = {
              provider = 'mini_pick',
            },
          },
        },
        keymaps = {
          close = {
            modes = {
              n = 'q',
              i = 'q',
            },
          },
          stop = {
            modes = {
              n = '<C-c>',
            },
          },
        },
      },
    },
    display = {
      diff = {
        provider = 'mini_diff',
      },
    },
  }

  map({ 'n', 'v' }, '<leader>ap', '<cmd>CodeCompanionActions<cr>', { desc = '[A]i Actions [P]rompt' })
  map({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle [A]i Chat' })
  map({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionChat Add<cr>', { desc = '[A]i add to [C]hat' })
  vim.cmd [[cab cc CodeCompanion]]
end

local function avante()
  add {
    source = 'yetone/avante.nvim',
    monitor = 'main',
    depends = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'echasnovski/mini.icons',
    },
    hooks = {
      post_checkout = function()
        vim.cmd 'AvanteBuild source=false'
      end,
    },
  }
  --- optional
  add { source = 'zbirenbaum/copilot.lua' }
  add { source = 'HakonHarnes/img-clip.nvim' }
  add { source = 'MeanderingProgrammer/render-markdown.nvim' }

  now(function()
    require('avante_lib').load()
  end)
  later(function()
    require('render-markdown').setup {}
  end)
  later(function()
    require('img-clip').setup {}
    require('copilot').setup {}
    require('avante').setup {}
  end)
end

local function codeium()
  add 'monkoose/neocodeium'
  local neocodeium = require 'neocodeium'
  neocodeium.setup {}
  map('i', '<tab>', function()
    if neocodeium.visible() then
      neocodeium.accept()
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<tab>', true, false, true), 'n', true)
    end
  end, { desc = 'Accept Codeium Suggestion' })
end

local function ai()
  supermaven()
  -- codeium()
  codecompanion()
  -- avante()
end

local function gitsigns()
  add 'lewis6991/gitsigns.nvim'

  require('gitsigns').setup {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    signs_staged = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
    },
    signcolumn = false,
    numhl = true,
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange' })

      -- Actions
      -- visual mode
      map('v', '<leader>ghs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[G]it [H]unk [S]tage ' })
      map('v', '<leader>ghr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[G]it [H]unk [R]eset ' })
      -- normal mode
      map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = '[G]it [H]unk [S]tage' })
      map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = '[G]it [H]unk [R]eset' })
      map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[G]it [S]tage buffer' })
      map('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = '[G]it [H]unk [U]ndo stage' })
      map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer' })
      map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = '[G]it [H]unk [p]review' })
      map('n', '<leader>gb', gitsigns.blame_line, { desc = '[G]it [B]lame line' })
      map('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it [D]iff against index' })
      map('n', '<leader>gD', function()
        gitsigns.diffthis '@'
      end, { desc = '[G]it [D]iff against last commit' })
      -- Toggles
      map('n', '<leader>tgb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle [G]it show [B]lame line' })
      map('n', '<leader>tgD', gitsigns.toggle_deleted, { desc = '[T]oggle [G]it show [D]eleted' })
    end,
  }
end

local function git()
  -- add "FabijanZulj/blame.nvim"
  -- add "almo7aya/openingh.nvim"
  -- require("blame").setup()
  -- require("openingh").setup()
  -- map({ "n", "v" }, "<leader>gb", "<cmd>BlameToggle<cr>", { desc = "Toggle git blame" })
  -- map({ "n", "v" }, "<leader>go", "<cmd>OpenInGHFile<cr>", { desc = "Open file in github" })
  -- map({ "n", "v" }, "<leader>gm", "<cmd>OpenInGHFile main<cr>", { desc = "Open file in github (main branch)" })
  -- add { source = "akinsho/git-conflict.nvim", checkout = "*" }
  ---@diagnostic disable-next-line: missing-fields
  -- require("git-conflict").setup {}
  add {
    source = 'NeogitOrg/neogit',
    depends = {
      'sindrets/diffview.nvim',
    },
  }
  require('neogit').setup {
    integrations = {
      diffview = true,
      mini_pick = true,
    },
  }

  gitsigns()

  map('n', '<leader>gn', '<cmd>Neogit<cr>', { desc = '[G]it Open [N]eogit' })
end

local function auto_session()
  add 'rmagatti/auto-session'
  require('auto-session').setup {
    log_level = 'error',
    suppressed_dirs = { '/', '~/', '~/src', '~/Downloads', '~/Desktop' },
    use_git_branch = true,
    bypass_save_filetypes = { 'NvimTree', 'Lazy', 'Starter' },
  }
  -- require('which-key').add {
  --   { '<leader>ws', group = '[W]orkspace [S]ession' },
  -- }
  map('n', '<leader>wsd', function()
    vim.cmd 'silent! SessionDelete' -- delete session
    vim.cmd 'silent! %bd' -- close all buffers
  end, { desc = '[W]orkspace [S]ession [D]elete' })
  map('n', '<leader>wsr', ':SessionRestore<cr>', { desc = '[W]orkspace [S]ession [R]estore' })
  vim.schedule(function()
    vim.cmd [[ SessionRestore ]]
  end)
end

local function auto_session_custom()
  local function create_session(session_name)
    local session_dir = vim.fn.stdpath 'data' .. '/session'
    vim.fn.mkdir(session_dir, 'p')

    local current_dir = vim.fn.getcwd()
    local git_dir = vim.fn.system('git -C ' .. vim.fn.shellescape(current_dir) .. ' rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')

    local base_dir = git_dir ~= '' and git_dir or current_dir
    local dir_name = vim.fn.fnamemodify(base_dir, ':t')

    session_name = session_name or dir_name
    local session_file = session_dir .. '/' .. session_name .. '.vim'

    vim.cmd('mksession! ' .. vim.fn.fnameescape(session_file))
    print('Session saved to: ' .. session_file)
  end

  local function delete_session(session_name)
    local session_dir = vim.fn.stdpath 'data' .. '/session'

    if session_name == nil or session_name == '' then
      -- List available sessions and prompt user to choose
      local sessions = vim.fn.glob(session_dir .. '/*.vim', false, true)
      if #sessions == 0 then
        print 'No sessions found.'
        return
      end
      print 'Available sessions:'
      for i, session in ipairs(sessions) do
        print(i .. '. ' .. vim.fn.fnamemodify(session, ':t:r'))
      end
      local choice = tonumber(vim.fn.input 'Enter the number of the session to delete (or 0 to cancel): ')
      if choice == nil or choice == 0 or choice > #sessions then
        print 'Deletion cancelled.'
        return
      end
      session_name = vim.fn.fnamemodify(sessions[choice], ':t:r')
    end

    local session_file = session_dir .. '/' .. session_name .. '.vim'

    if vim.fn.filereadable(session_file) == 1 then
      local confirm = vim.fn.input("Are you sure you want to delete the session '" .. session_name .. "'? (y/N): ")
      if confirm:lower() == 'y' then
        vim.fn.delete(session_file)
        print("Session '" .. session_name .. "' deleted.")
      else
        print 'Deletion cancelled.'
      end
    else
      print("Session '" .. session_name .. "' not found.")
    end
  end

  later(function()
    -- require('which-key').add {
    --   { '<leader>ws', group = '[W]orkspace [S]ession' },
    --   { '<leader>wsc', group = '[W]orkspace [S]ession [C]reate' },
    --   { '<leader>wsd', group = '[W]orkspace [S]ession [D]elete' },
    -- }
    -- Command to create a session
    vim.api.nvim_create_user_command('CreateSession', function(opts)
      create_session(opts.args ~= '' and opts.args or nil)
    end, { nargs = '?', desc = 'Create a session for the current directory or Git repository' })
    map('n', '<leader>wsc', '<cmd>CreateSession<cr>', { desc = '[W]orkspace [S]ession [C]reate' })

    -- Command to delete a session
    vim.api.nvim_create_user_command('DeleteSession', function(opts)
      delete_session(opts.args ~= '' and opts.args or nil)
    end, { nargs = '?', desc = 'Delete a session file' })

    map('n', '<leader>wsd', '<cmd>DeleteSession<cr>', { desc = '[W]orkspace [S]ession [D]elete' })
  end)
end

local function mini_nvim()
  add 'echasnovski/mini.nvim'
  -- require('mini.completion').setup {}
  require('mini.comment').setup {}
  require('mini.indentscope').setup { symbol = '│' }
  vim.cmd 'hi! link MiniIndentscopeSymbol Whitespace'

  -- require('mini.cursorword').setup {}
  -- vim.api.nvim_command 'hi! link MiniCursorWord CursorLine'
  -- vim.api.nvim_command 'hi! link MiniCursorWordCurrent CursorLine'

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup { n_lines = 500 }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - gsaiw) - g[S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - gsd'   - g[S]urround [D]elete [']quotes
  -- - gsr)'  - g[S]urround [R]eplace [)] [']
  require('mini.surround').setup {
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      add = 'gsa', -- Add surrounding in Normal and Visual modes
      delete = 'gsd', -- Delete surrounding
      find = 'gsf', -- Find surrounding (to the right)
      find_left = 'gsF', -- Find surrounding (to the left)
      highlight = 'gsh', -- Highlight surrounding
      replace = 'gsr', -- Replace surrounding
      update_n_lines = 'gsn', -- Update `n_lines`
      suffix_last = 'l', -- Suffix to search with "prev" method
      suffix_next = 'n', -- Suffix to search with "next" method
    },
  }

  require('mini.hipatterns').setup()

  require('mini.pairs').setup()

  require('mini.bracketed').setup {
    window = { suffix = 'W', options = {} },
  }

  require('mini.pick').setup {
    mappings = {
      to_quickfix = {
        char = '<c-q>',
        func = function()
          local items = MiniPick.get_picker_items() or {}
          MiniPick.default_choose_marked(items)
          MiniPick.stop()
        end,
      },
    },
  }
  require('mini.extra').setup()

  vim.ui.select = MiniPick.ui_select
  map('n', '<leader>sh', '<cmd>Pick help<cr>', { desc = '[S]earch [H]elp' })
  map('n', '<leader>sk', '<cmd>Pick keymaps<cr>', { desc = '[S]earch [K]eymaps' })
  map('n', '<leader>sf', '<cmd>Pick files<cr>', { desc = '[S]earch [F]iles' })
  map('n', '<leader> ', "<cmd>Pick files tool='git'<cr>", { desc = 'Search Git Files' })
  map('n', '<leader>ss', '<cmd>Pick lsp<cr>', { desc = '[S]earch [S]elect ' })
  map('n', '<leader>sw', '<cmd>Pick grep<cr>', { desc = '[S]earch current [W]ord' })
  map('n', '<leader>sg', '<cmd>Pick grep_live<cr>', { desc = '[S]earch by [G]rep' })
  map('n', '<leader>sd', '<cmd>Pick diagnostic<cr>', { desc = '[S]earch [D]iagnostics' })
  map('n', '<leader>sR', '<cmd>Pick resume<cr>', { desc = '[S]earch [R]esume' })
  map('n', '<leader>s.', '<cmd>Pick history<cr>', { desc = '[S]earch Recent Files ("." for repeat)' })
  map('n', '<leader><leader>', '<cmd>Pick buffers<cr>', { desc = '[ ] Find existing buffers' })

  -- Simple and easy statusline.
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'

  local icons = require 'mini.icons'

  -- Cache for the recorder module
  local recorder_cache = {
    exists = nil,
    module = nil,
  }
  local function get_recorder()
    -- Check if we've already tried to load the module
    if recorder_cache.exists == nil then
      recorder_cache.exists, recorder_cache.module = pcall(require, 'recorder')
    end

    return recorder_cache.exists, recorder_cache.module
  end

  local recorder_status = function()
    local recorder_exists, recorder = get_recorder()
    if recorder_exists and recorder then
      return recorder.recordingStatus()
    end
    return ''
  end
  local fileinfo = function()
    local filetype = vim.bo.filetype

    -- Don't show anything if there is no filetype
    if filetype == '' then
      return ''
    end

    -- Add filetype icon
    filetype = icons.get('filetype', filetype) .. ' ' .. filetype

    return filetype
  end
  local location = function()
    return '%2l:%-2v'
  end

  -- set use_icons to true if you have a Nerd Font
  statusline.setup {
    use_icons = true,
    content = {
      active = function()
        local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
        local branch = statusline.section_git { trunc_width = 40 }
        local diagnostics = statusline.section_diagnostics { trunc_width = 40 }
        local filename = statusline.section_filename { trunc_width = 140 }
        local search = statusline.section_searchcount { trunc_width = 75 }
        local recorder = recorder_status()

        return statusline.combine_groups {
          { hl = mode_hl, strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { branch } },
          '%<', -- Mark general truncate point
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=', -- End left alignment
          { hl = mode_hl, strings = { recorder, search, diagnostics } },
        }
      end,
    },
  }

  -- require('mini.diff').setup {
  --   mappings = {
  --     apply = 'gh',
  --     reset = 'gH',
  --     textobject = 'gh',
  --     goto_first = '[G',
  --     goto_prev = '[g',
  --     goto_next = ']g',
  --     goto_last = ']G',
  --   },
  -- }
  -- map('n', '<leader>gd', function()
  --   require('mini.diff').toggle_overlay(vim.api.nvim_get_current_buf())
  -- end, { desc = 'Toggle overlay diff in the whole file' })
  -- map('n', '<leader>gr', function()
  --   vim.cmd 'normal gHgh'
  -- end, { desc = 'Reset hunk' })
  -- map('v', '<leader>gr', function()
  --   vim.cmd 'normal gH'
  -- end, { desc = 'Reset visual selection' })
  -- map('n', '<leader>gs', function()
  --   vim.cmd 'normal ghgh'
  -- end, { desc = 'Stage hunk' })
  -- map('v', '<leader>gs', function()
  --   vim.cmd 'normal gh'
  -- end, { desc = 'Stage visual selection' })

  require('mini.splitjoin').setup {}
  require('mini.files').setup {
    mappings = {
      go_in_plus = '<cr>',
      synchronize = '=',
    },
    windows = {
      preview = true,
      width_preview = 60,
    },
  }
  local show_dotfiles = true
  local filter_show = function(fs_entry)
    return true
  end
  local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
  end

  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    require('mini.files').refresh { content = { filter = new_filter } }
  end
  local map_split = function(buf_id, lhs, direction, close_on_file)
    local rhs = function()
      local new_target_window
      local cur_target_window = require('mini.files').get_explorer_state().target_window
      if cur_target_window ~= nil then
        vim.api.nvim_win_call(cur_target_window, function()
          vim.cmd('belowright ' .. direction .. ' split')
          new_target_window = vim.api.nvim_get_current_win()
        end)

        require('mini.files').set_target_window(new_target_window)
        require('mini.files').go_in { close_on_file = close_on_file }
      end
    end

    local desc = 'Open in ' .. direction .. ' split'
    if close_on_file then
      desc = desc .. ' and close'
    end
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
  end
  local files_set_cwd = function()
    local cur_entry_path = MiniFiles.get_fs_entry().path
    local cur_directory = vim.fs.dirname(cur_entry_path)
    if cur_directory ~= nil then
      vim.fn.chdir(cur_directory)
    end
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id

      vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle hidden files' })

      vim.keymap.set('n', 'gc', files_set_cwd, { buffer = args.data.buf_id, desc = 'Set cwd' })

      map_split(buf_id, '<C-w>s', 'horizontal', false)
      map_split(buf_id, '<C-w>v', 'vertical', false)
      map_split(buf_id, '<C-w>S', 'horizontal', true)
      map_split(buf_id, '<C-w>V', 'vertical', true)
    end,
  })

  map({ 'n', 'v' }, '<leader>e', function()
    local MiniFiles = require 'mini.files'
    if not MiniFiles.close() then
      local is_buffer_a_file = (vim.api.nvim_get_option_value('buftype', { buf = 0 }) == '')
      if is_buffer_a_file then
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      else
        MiniFiles.open()
      end
    end
  end, { desc = 'Toggle file [E]xplorer' })
  require('mini.icons').setup {
    opts = {
      file = {
        ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
        ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
        ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
        ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
        ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
        ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
        ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
      },
    },
  }
  MiniIcons.mock_nvim_web_devicons()
end

-- Highlight, edit, and navigate code
local function treesitter()
  add 'nvim-treesitter/nvim-treesitter'
  ---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },

    -- Autoinstall languages that are not installed
    auto_install = true,

    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        node_decremental = '<bs>',
        scope_incremental = false,
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  }

  vim.filetype.add {
    pattern = {
      ['.*%.blade%.php'] = 'blade',
    },
  }
  require('nvim-treesitter.configs').setup {}
  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
  parser_config.blade = {
    install_info = {
      url = 'https://github.com/EmranMR/tree-sitter-blade',
      files = { 'src/parser.c' },
      branch = 'main',
    },
    filetype = 'blade',
  }
end

local function autotag()
  add 'windwp/nvim-ts-autotag'
  require('nvim-ts-autotag').setup {}
end

local function lazydev()
  add 'folke/lazydev.nvim'
end

-- Brief aside: **What is LSP?**
--
-- LSP is an initialism you've probably heard, but might not understand what it is.
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`
local function lsp()
  -- vim.lsp.inlay_hint.enable() -- enable inlay hints
  add 'neovim/nvim-lspconfig'
  add 'folke/neodev.nvim'
  add 'williamboman/mason.nvim'
  add 'williamboman/mason-lspconfig.nvim'
  add 'WhoIsSethDaniel/mason-tool-installer.nvim'
  -- Useful status updates for LSP.
  add 'j-hui/fidget.nvim'
  -- Allows extra capabilities provided by nvim-cmp
  add 'hrsh7th/cmp-nvim-lsp'

  local function mini_completion_on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.MiniCompletion.completefunc_lsp')
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  require('neodev').setup {}
  require('mason').setup {}
  require('mason-lspconfig').setup {
    ensure_installed = {
      'bashls',
      'jsonls',
      'html',
      'vimls',
      'lua_ls',
      'astro',
      -- 'biome',
      'eslint',
      'vtsls',
      'volar',
      'tailwindcss',
      'intelephense',
      -- "zls", --for zig
    },
  }

  map('n', 'E', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

  -- diagnostic
  local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
      go { severity = severity }
      vim.cmd 'normal! zz'
    end
  end
  map('n', ']d', diagnostic_goto(true), { desc = 'Next [D]iagnostic' })
  map('n', '[d', diagnostic_goto(false), { desc = 'Prev [D]iagnostic' })
  map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next [E]rror' })
  map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev [E]rror' })
  map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next [W]arning' })
  map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev [W]arning' })
  map('n', '<leader>td', function()
    if vim.diagnostic.enable then
      pcall(vim.diagnostic.enable, false)
    else
      pcall(vim.diagnostic.enable, true)
    end
  end, { desc = '[T]oggle [D]iagnostics' })

  map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  map('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })

  -- Find references for the word under your cursor.
  -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('n', 'gr', vim.lsp.buf.references, { desc = '[G]oto [R]eferences' })

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  -- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  map('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  map('n', '<leader>D', vim.lsp.buf.definition, { desc = 'Type [D]efinition' })

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  map('n', '<leader>ds', vim.lsp.buf.document_symbol, { desc = '[D]ocument [S]ymbols' })

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  -- map('n', '<leader>ws', vim.lsp.buf.workspace_symbol, { desc = '[W]orkspace [S]ymbols' })

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map('n', '<leader>cr', vim.lsp.buf.rename, { desc = '[C]ode [R]ename' })

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
  map({ 'n', 'x' }, '<leader>.', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })

  map('n', '<leader>ls', ':LspStart<cr>', { desc = '[L]SP [S]tart' })
  map('n', '<leader>lx', ':LspStop<cr>', { desc = '[L]SP [X]lose' })
  map('n', '<leader>lr', ':LspRestart<cr>', { desc = '[L]SP [R]estart' })
  map('n', '<leader>li', ':LspInfo<cr>', { desc = '[L]SP [I]nfo' })
  map('n', '<leader>lh', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
  end, { desc = '[L]SP Toggle inlay [H]ints' })

  local lspconfig = require 'lspconfig'
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local on_attach = function(client, buffer)
    -- mini_completion_on_attach(client, buffer)

    -- we use conform to format
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = buffer,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = buffer,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('user-lsp-codelens', { clear = true }),
        buffer = buffer,
        callback = vim.lsp.codelens.refresh,
      })
    end

    vim.diagnostic.config {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        -- prefix = '●',
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = 'icons',
      },
      severity_sort = true,
      -- signs = {
      --   text = {
      --     -- [vim.diagnostic.severity.ERROR] = ' ',
      --     -- [vim.diagnostic.severity.WARN] = ' ',
      --     -- [vim.diagnostic.severity.HINT] = ' ',
      --     -- [vim.diagnostic.severity.INFO] = ' ',
      --     [vim.diagnostic.severity.ERROR] = '●',
      --     [vim.diagnostic.severity.WARN] = '● ',
      --     [vim.diagnostic.severity.HINT] = '● ',
      --     [vim.diagnostic.severity.INFO] = '● ',
      --   },
      -- },
    }
  end

  -- LSP servers and clients are able to communicate to each other what features they support.
  --  By default, Neovim doesn't support everything that is in the LSP specification.
  --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
  --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  local function setup_lsp(lsp_name, settings, opts)
    -- lspconfig[lsp_name].setup {
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   settings = settings,
    -- }
    opts = opts or {}
    local setup_config = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = settings,
    }

    for k, v in pairs(opts) do
      setup_config[k] = v
    end

    lspconfig[lsp_name].setup(setup_config)
  end

  lazydev()
  local function get_pkg_path(pkg, path)
    local mason_root = vim.fn.stdpath 'data' .. '/mason'
    local ret = mason_root .. '/packages/' .. pkg .. '/' .. path
    if not vim.loop.fs_stat(ret) then
      print(('Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package.'):format(pkg, path))
    end
    return ret
  end
  setup_lsp('tailwindcss', {
    tailwindCSS = {
      includeLanguages = {
        elixir = 'html-eex',
        eelixir = 'html-eex',
        heex = 'html-eex',
        blade = 'html',
      },
    },
  })

  setup_lsp 'volar'

  local typescriptSettings = {
    updateImportsOnFileMove = { enabled = 'always' },
    suggest = {
      completeFunctionCalls = true,
    },
    tsserver = { maxTsServerMemory = 8192 },
    inlayHints = {
      enumMemberValues = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      parameterNames = { enabled = 'literals' },
      parameterTypes = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      variableTypes = { enabled = false },
    },
  }
  setup_lsp('vtsls', {
    complete_function_calls = true,
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = get_pkg_path('vue-language-server', '/node_modules/@vue/language-server'),
            languages = { 'vue' },
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
    typescript = typescriptSettings,
    javascript = typescriptSettings,
    vue = typescriptSettings,
  }, {
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'vue',
    },
  })
  setup_lsp 'vimls'
  setup_lsp 'bashls'
  setup_lsp 'jsonls'
  setup_lsp 'html'
  setup_lsp 'astro'
  -- setup_lsp 'biome'
  setup_lsp 'eslint'
  setup_lsp('lua_ls', {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      hint = { enable = true },
      workspace = {
        checkThirdParty = false,
      },
    },
  })
  setup_lsp 'intelephense'
  -- setup_lsp "zls"
end

local function trouble()
  add 'folke/trouble.nvim'
  require('trouble').setup {}
  map('n', '<leader>d', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Toggle trouble diagnostics' })
  map('n', '<leader>q', '<cmd>Trouble qflist toggle<cr>', { desc = 'Toggle trouble [Q]uickfix' })
end

local function conform()
  add 'stevearc/conform.nvim'
  require('conform').setup {
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      blade = { 'blade-formatter' },
      json = { 'prettierd' },
      jsx = { 'prettierd' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      vue = { 'prettierd' },
      html = { 'prettierd' },
      css = { 'prettierd' },
      graphql = { 'prettierd' },
      markdown = { 'prettierd' },
      yaml = { 'prettierd' },
    },
  }
  map('n', '<leader>bf', function()
    require('conform').format { async = true, lsp_format = 'fallback' }
  end, { desc = '[B]uffer [F]ormat' })

  map('n', '<leader>tf', function()
    if vim.b.disable_autoformat then
      vim.b.disable_autoformat = false
      print 'Enabled buffer autoformat'
    else
      vim.b.disable_autoformat = true
      print 'Disabled buffer autoformat'
    end
  end, { desc = '[T]oggle Buffer [F]ormat' })

  map('n', '<leader>tF', function()
    if vim.g.disable_autoformat then
      vim.g.disable_autoformat = false
      print 'Enabled workspace autoformat'
    else
      vim.g.disable_autoformat = true
      print 'Disabled workspace autoformat'
    end
  end, { desc = '[T]oggle Workspace [F]ormat' })
end

local function noice()
  add {
    source = 'folke/noice.nvim',
    depends = {
      'MunifTanjim/nui.nvim',
    },
  }
  require('noice').setup {
    -- lsp = { progress = { enabled = false } },
    -- notify = { enabled = true, view = 'notify' },
    -- messages = { enabled = true, view = 'notify' },
    -- cmdline = { view = 'cmdline_popup' },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  }
end

local function grug()
  add 'MagicDuck/grug-far.nvim'

  local g = require 'grug-far'
  g.setup {}

  map('n', '<leader>sr', function()
    local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
    g.open {
      transient = true,
      prefills = {
        filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
      },
    }
  end, {
    desc = '[S]earch and [R]eplace',
  })
  map('v', '<leader>sr', function()
    local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
    g.with_visual_selection {
      transient = true,
      prefills = {
        filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
      },
    }
  end, {
    desc = '[S]earch and [R]eplace with selection as input',
  })
end

local function highlight_colors()
  add 'brenoprata10/nvim-highlight-colors'
  require('nvim-highlight-colors').setup {}
end

local function todo_comments()
  add 'folke/todo-comments.nvim'
  require('todo-comments').setup {
    signs = false,
  }
  map('n', ']t', function()
    require('todo-comments').jump_next { 'FIX', 'TODO' }
  end, { desc = 'Next todo comment' })

  map('n', '[t', function()
    require('todo-comments').jump_prev { 'FIX', 'TODO' }
  end, { desc = 'Previous todo comment' })

  -- map('n', '<leader>xt', '<cmd>TodoTrouble<cr>', { desc = 'Toggle [X]todo [T]rouble' })
  map('n', '<leader>xt', '<cmd>TodoQuickFix<cr>', { desc = 'Open Todo' })
end

local function harpoon()
  add {
    source = 'ThePrimeagen/harpoon',
    checkout = 'harpoon2',
  }

  require('harpoon').setup {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  }

  map('n', '<leader>H', function()
    require('harpoon'):list():add()
  end, { desc = 'Add Harpoon File' })

  map('n', '<leader>tp', function()
    local harpoon = require 'harpoon'
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = '[T]oggle Har[P]oon Quick Menu' })

  for i = 1, 5 do
    map('n', '<leader>' .. i, function()
      require('harpoon'):list():select(i)
    end, { desc = 'Harpoon to File ' .. i })
  end
end

local function zen_mode()
  add 'folke/zen-mode.nvim'
  add 'folke/twilight.nvim'

  map('n', '<leader>z', ':ZenMode<cr>', { desc = 'Toggle [Z]en mode' })
end

local function nvim_recorder()
  add 'chrisgrieser/nvim-recorder'
  require('recorder').setup {
    mapping = {
      startStopRecording = 'q',
      playMacro = 'Q',
    },
  }
end

local function snipe()
  add 'leath-dub/snipe.nvim'

  require('snipe').setup {}

  map('n', 'gb', function()
    require('snipe').open_buffer_menu()
  end, { desc = 'Open Snipe buffer menu' })
end

local function toggleterm()
  add 'akinsho/toggleterm.nvim'
  require('toggleterm').setup {
    open_mapping = '<c-/>',
    size = 22,
  }
  local Terminal = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new {
    cmd = 'lazygit',
    dir = 'git_dir',
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
    hidden = true,
  }

  local function _lazygit_toggle()
    lazygit:toggle()
  end

  map('n', '<leader>gg', _lazygit_toggle, { desc = '[G]it Open Lazy[G]it' })
  map('n', '<c-/>', '<cmd>ToggleTerm<cr>', { desc = 'Toggle Terminal' })
end

local function leap()
  add 'ggandor/leap.nvim'

  map({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
  map({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
  map({ 'n', 'x', 'o' }, 'gz', '<Plug>(leap-from-window)')

  -- require('leap').add_default_mappings(true)
  -- vim.keymap.del({ 'x', 'o' }, 'x')
  -- vim.keymap.del({ 'x', 'o' }, 'X')
end

local function flit()
  add 'ggandor/flit.nvim'
  require('flit').setup {}
end

local function nvim_ufo()
  add {
    source = 'kevinhwang91/nvim-ufo',
    depends = { 'kevinhwang91/promise-async' },
  }

  local ufo = require 'ufo'

  vim.opt.foldcolumn = '0' -- '0' is not bad
  vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.opt.foldlevelstart = 99
  vim.opt.foldenable = true
  -- global handler
  -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
  -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
  ufo.setup {
    close_fold_kinds_for_ft = {
      default = { 'imports', 'comment' },
      json = { 'array' },
      c = { 'comment', 'region' },
    },
    open_fold_hl_timeout = 0,
    provider_selector = function(_, filetype)
      return { 'treesitter', 'indent' }
    end,
    fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
      local _start = lnum - 1
      local _end = end_lnum - 1
      local start_text = vim.api.nvim_buf_get_text(0, _start, 0, _start, -1, {})[1]
      local final_text = vim.trim(vim.api.nvim_buf_get_text(0, _end, 0, _end, -1, {})[1])
      return start_text .. ' ⋯ ' .. final_text .. (' 󰁂 %d '):format(end_lnum - lnum)
    end,
  }

  map('n', 'zR', require('ufo').openAllFolds)
  map('n', 'zM', require('ufo').closeAllFolds)
  map('n', 'zr', require('ufo').openFoldsExceptKinds)
  map('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
  map('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
      -- choose one of coc.nvim and nvim lsp
      -- vim.fn.CocActionAsync('definitionHover') -- coc.nvim
      vim.lsp.buf.hover()
    end
  end)
end

local function overseer()
  add 'stevearc/overseer.nvim'

  require('overseer').setup {
    dap = false,
    task_list = {
      bindings = {
        ['<C-h>'] = false,
        ['<C-j>'] = false,
        ['<C-k>'] = false,
        ['<C-l>'] = false,
      },
    },
    form = {
      win_opts = {
        winblend = 0,
      },
    },
    confirm = {
      win_opts = {
        winblend = 0,
      },
    },
    task_win = {
      win_opts = {
        winblend = 0,
      },
    },
  }

  -- require('which-key').add {
  --   { '<leader>wt', group = '[W]orkspace [T]asks' },
  -- }
  map('n', '<leader>wtl', '<cmd>OverseerToggle<cr>', { desc = '[W]orkspace [T]asks [L]ist' })
  map('n', '<leader>wtr', '<cmd>OverseerRun<cr>', { desc = '[W]orkspace [T]asks [R]un' })
  map('n', '<leader>wtq', '<cmd>OverseerQuickAction<cr>', { desc = '[W]orkspace [T]asks [Q]uick Run' })
  map('n', '<leader>wti', '<cmd>OverseerInfo<cr>', { desc = '[W]orkspace [T]asks [I]nfo' })
  map('n', '<leader>wtb', '<cmd>OverseerBuild<cr>', { desc = '[W]orkspace [T]asks [B]uilder' })
  map('n', '<leader>wta', '<cmd>OverseerTaskAction<cr>', { desc = '[W]orkspace [T]asks [A]ction' })
  map('n', '<leader>wtc', '<cmd>OverseerClearCache<cr>', { desc = '[W]orkspace [T]asks [C]lear cache' })
end

local function dashboard()
  -- add 'echasnovski/mini.sessions'
  -- require('mini.sessions').setup {}
  add 'folke/persistence.nvim'
  require('persistence').setup {}

  add 'echasnovski/mini.starter'
  local starter = require 'mini.starter'
  local pad = string.rep(' ', 22)
  starter.setup {
    evaluate_single = true,
    items = {
      starter.sections.builtin_actions(),
      {
        name = 'Restore session',
        action = [[lua require("persistence").load()]],
        section = 'Sessions',
      },
      -- starter.sections.sessions(5, true),
      starter.sections.recent_files(5, false),
      -- starter.sections.recent_files(10, true),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(pad .. '░ ', false),
      starter.gen_hook.indexing('all', { 'Builtin actions', 'Sessions' }),
      starter.gen_hook.aligning('center', 'center'),
      -- starter.gen_hook.adding_bullet(),
      -- starter.gen_hook.padding(3, 2),
    },
  }

  -- add 'nvimdev/dashboard-nvim'
  -- require('dashboard').setup {}
end

local function completion()
  add {
    source = 'hrsh7th/nvim-cmp',
    depends = {
      {
        source = 'L3MON4D3/LuaSnip',
        hooks = {
          post_install = function()
            -- Build Step is needed for regex support in snippets.
            -- This step is not supported in many windows environments.
            -- Remove the below condition to re-enable on windows.
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
              return
            end
            return 'make install_jsregexp'
          end,
        },
      },
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
  }

  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
  luasnip.config.setup {}
  require('luasnip.loaders.from_vscode').lazy_load()

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },
    formatting = {
      -- kind icon / color icon + completion + kind text
      fields = { 'menu', 'abbr', 'kind' },

      format = function(entry, item)
        local entryItem = entry:get_completion_item()
        local color = entryItem.documentation

        -- check if color is hexcolor
        if color and type(color) == 'string' and color:match '^#%x%x%x%x%x%x$' then
          local hl = 'hex-' .. color:sub(2)

          if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then
            vim.api.nvim_set_hl(0, hl, { fg = color })
          end

          item.menu = ' '
          item.menu_hl_group = hl

          -- else
          -- add your lspkind icon here!
          -- item.menu_hl_group = item.kind_hl_group
        end

        return item
      end,
    },

    -- For an understanding of why these mappings were
    -- chosen, you will need to read `:help ins-completion`
    --
    -- No, but seriously. Please read `:help ins-completion`, it is really good!
    mapping = cmp.mapping.preset.insert {
      -- Select the [n]ext item
      ['<C-n>'] = cmp.mapping.select_next_item(),
      -- Select the [p]revious item
      ['<C-p>'] = cmp.mapping.select_prev_item(),

      -- Scroll the documentation window [b]ack / [f]orward
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),

      -- Accept ([y]es) the completion.
      --  This will auto-import if your LSP supports it.
      --  This will expand snippets if the LSP sent a snippet.
      ['<C-y>'] = cmp.mapping.confirm { select = true },

      -- If you prefer more traditional completion keymaps,
      -- you can uncomment the following lines
      --['<CR>'] = cmp.mapping.confirm { select = true },
      --['<Tab>'] = cmp.mapping.select_next_item(),
      --['<S-Tab>'] = cmp.mapping.select_prev_item(),

      -- Manually trigger a completion from nvim-cmp.
      --  Generally you don't need this, because nvim-cmp will display
      --  completions whenever it has completion options available.
      ['<C-Space>'] = cmp.mapping.complete {},

      -- Think of <c-l> as moving to the right of your snippet expansion.
      --  So if you have a snippet that's like:
      --  function $name($args)
      --    $body
      --  end
      --
      -- <c-l> will move you to the right of each of the expansion locations.
      -- <c-h> is similar, except moving you backwards.
      ['<C-l>'] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { 'i', 's' }),
      ['<C-h>'] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { 'i', 's' }),

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },
    sources = {
      {
        name = 'lazydev',
        -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
        group_index = 0,
      },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
    },
  }
end

local function blink_completion()
  add {
    source = 'saghen/blink.cmp',
    depends = {
      'rafamadriz/friendly-snippets',
    },
    checkout = 'v0.3.1',
  }
  require('blink.cmp').setup {}
end

local function markdown()
  add 'OXY2DEV/markview.nvim'
end

local function dap()
  add {
    source = 'mfussenegger/nvim-dap',
    depends = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
  }
  local dap = require 'dap'
  local dapui = require 'dapui'

  require('mason-nvim-dap').setup {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_installation = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed = {
      -- Update this to ensure that you have the debuggers for the langs you want
      'delve',
    },
  }

  -- Dap UI setup
  -- For more information, see |:help nvim-dap-ui|
  dapui.setup {
    -- Set icons to characters that are more likely to work in every terminal.
    --    Feel free to remove or use ones that you like more! :)
    --    Don't feel like these are good choices.
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  -- Install golang specific config
  require('dap-go').setup {
    delve = {
      -- On Windows delve must be run attached or it crashes.
      -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
      detached = vim.fn.has 'win32' == 0,
    },
  }
  -- mappings
  map('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
  map('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
  map('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
  map('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
  map('n', '<leader>tdb', dap.toggle_breakpoint, { desc = '[T]oggle [D]ebug [B]reakpoint' })
  map('n', '<leader>tdB', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = '[T]oggle [D]ebug [B]reakpoint with condition' })
  -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
  map('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
end

local function lint()
  add 'mfussenegger/nvim-lint'
  local lint = require 'lint'
  lint.linters_by_ft = {
    markdown = { 'markdownlint' },
  }

  -- To allow other plugins to add linters to require('lint').linters_by_ft,
  -- instead set linters_by_ft like this:
  -- lint.linters_by_ft = lint.linters_by_ft or {}
  -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
  --
  -- However, note that this will enable a set of default linters,
  -- which will cause errors unless these tools are available:
  -- {
  --   clojure = { "clj-kondo" },
  --   dockerfile = { "hadolint" },
  --   inko = { "inko" },
  --   janet = { "janet" },
  --   json = { "jsonlint" },
  --   markdown = { "vale" },
  --   rst = { "vale" },
  --   ruby = { "ruby" },
  --   terraform = { "tflint" },
  --   text = { "vale" }
  -- }
  --
  -- You can disable the default linters by setting their filetypes to nil:
  -- lint.linters_by_ft['clojure'] = nil
  -- lint.linters_by_ft['dockerfile'] = nil
  -- lint.linters_by_ft['inko'] = nil
  -- lint.linters_by_ft['janet'] = nil
  -- lint.linters_by_ft['json'] = nil
  -- lint.linters_by_ft['markdown'] = nil
  -- lint.linters_by_ft['rst'] = nil
  -- lint.linters_by_ft['ruby'] = nil
  -- lint.linters_by_ft['terraform'] = nil
  -- lint.linters_by_ft['text'] = nil

  -- Create autocommand which carries out the actual linting
  -- on the specified events.
  local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })
end

local function nvim_tree()
  add {
    source = 'nvim-neo-tree/neo-tree.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
  }

  require('neo-tree').setup {
    filesystem = {
      window = {
        mappings = {
          ['<leader>tn'] = 'close_window',
        },
      },
    },
  }

  map('n', '<Leader>tn', ':Neotree reveal<CR>', { desc = '[T]oggle [N]eoTree' })
end

local function multi_cursor()
  add {
    source = 'smoka7/multicursors.nvim',
    depends = {
      'nvimtools/hydra.nvim',
    },
  }
  require('multicursors').setup {}

  map({ 'n', 'v' }, '<leader>m', '<cmd>MCstart<cr>', { desc = 'Multi Cursor' })
end

-- Lazy load plugins
local function setup_plugins()
  noice()
  plugins_that_should_be_the_default()
  which_key()
  -- auto_session()
  -- auto_session_custom()
  -- telescope()
  grug()
  git()
  mini_nvim()
  treesitter()
  autotag()
  lsp()
  completion()
  ai()
  -- trouble()
  conform()
  highlight_colors()
  todo_comments()
  harpoon()
  zen_mode()
  nvim_recorder()
  snipe()
  toggleterm()
  leap()
  flit()
  nvim_ufo()
  overseer()
  markdown()
  dap()
  lint()
  nvim_tree()
  multi_cursor()
end

setup_plugin_manager()

now(function()
  setup_options()
  setup_priority_plugins()
  dashboard()
end)

later(function()
  setup_mappings()
  setup_autocommands()
  setup_plugins()
end)
