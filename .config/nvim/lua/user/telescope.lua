local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

local _status, lga_actions = pcall(require, "telescope-live-grep-args.actions")

telescope.setup {
  defaults = {
    -- prompt_prefix = " ",
    prompt_prefix = "🔍 ",
    selection_caret = "→ ",
    path_display = { "absolute" },
    file_ignore_patterns = { ".git/", "node_modules" },
    hidden_files = true,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--ignore",
      "--iglob",
      "!public/**"
    },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<ESC>"] = actions.close,
      },
    },
  },

  pickers = {
    find_files = {
      theme = "dropdown",
      i = {
        ["<ESC>"] = actions.close,
      },
    },
    live_grep = {
      theme = "dropdown",
    },
    projects = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
    },
    help_tags = {
      theme = "dropdown",
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                      -- the default case_mode is "smart_case"
    },
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    project = {
      base_dirs = {
        {'~/Developer', max_depth = 3},
      },
      hidden_files = true, -- default: false
      theme = "dropdown"
    },
    frecency = {
      default_workspace = "CWD",
      ignore_patterns = {"*.git/*", "*/tmp/*", "public/*"},
      disable_devicons = false,
    },
    live_grep_args = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--ignore",
        "--iglob",
        "!public/**"
      },
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = {
        i = {
          ["<Down>"] = actions.cycle_history_next,
          ["<Up>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<ESC>"] = actions.close,
          ["<C-e>"] =  lga_actions and lga_actions.quote_prompt() or nil,
          ["<C-l>g"] = lga_actions and lga_actions.quote_prompt({ postfix = ' --iglob ' }) or nil,
          ["<C-l>t"] = lga_actions and lga_actions.quote_prompt({ postfix = ' -t' }) or nil,
        }
      }
    }
  }
}
telescope.load_extension('fzf', 'file_browser', 'ui-select', 'project', 'frecency', 'harpoon', 'live_grep_args')


