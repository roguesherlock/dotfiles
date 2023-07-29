local actions = require "telescope.actions"

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        config = function()
          local _status, lga_actions = pcall(require,
                                             "telescope-live-grep-args.actions")
          require("telescope").setup({
            extensions = {
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
                    ["<D-j>"] = actions.move_selection_next,
                    ["<D-k>"] = actions.move_selection_previous,
                    ["<ESC>"] = actions.close,
                    ["<C-e>"] = lga_actions and lga_actions.quote_prompt() or
                      nil,
                    ["<D-e>"] = lga_actions and lga_actions.quote_prompt() or
                      nil,
                    ["<C-l>g"] = lga_actions and lga_actions.quote_prompt({
                      postfix = " --iglob "
                    }) or nil,
                    ["<C-l>t"] = lga_actions and lga_actions.quote_prompt({
                      postfix = " -t"
                    }) or nil
                  }
                }
              }

            }
          })
          require("telescope").load_extension("live_grep_args")
        end
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = {
          "kkharji/sqlite.lua"
        },
        config = function()
          require("telescope").load_extension("frecency")
        end
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        config = function()
          require("telescope").load_extension("fzf")
        end
      },
      {
        "ThePrimeagen/harpoon",
        config = function()
          require("telescope").load_extension("harpoon")
        end

      }
    },
    opts = {
      defaults = {
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
            ["<D-j>"] = actions.move_selection_next,
            ["<D-k>"] = actions.move_selection_previous,
            ["<ESC>"] = actions.close
          }
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            i = {
              ["<ESC>"] = actions.close
            }
          },
          buffers = {
            theme = "dropdown"
          },
          projects = {
            theme = "dropdown"
          }
        }
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case" -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        project = {
          base_dirs = {
            {
              "~/Developer",
              max_depth = 3
            }
          },
          hidden_files = true, -- default: false
          theme = "dropdown"
        },
        frecency = {
          default_workspace = "CWD",
          ignore_patterns = {
            "*.git/*",
            "*/tmp/*",
            "public/*"
          },
          disable_devicons = false
        }

      }
    }

  }
}
