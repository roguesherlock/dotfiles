return {
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util")

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = {
            statusline = {
              "dashboard",
              "alpha"
            }
          }
        },
        sections = {
          lualine_a = {
            "mode"
          },
          lualine_b = {
            "branch"
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint
              }
            },
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = {
                left = 1,
                right = 0
              }
            },
            {
              "filename",
              path = 1,
              symbols = {
                modified = "  ",
                readonly = "",
                unnamed = ""
              }
            },
            -- stylua: ignore
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"] and
                         require("nvim-navic").is_available()
              end
            }
          },
          lualine_x = {
            -- stylua: ignore
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and
                         require("noice").api.status.command.has()
              end,
              color = Util.fg("Statement")
            },
            -- stylua: ignore
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and
                         require("noice").api.status.mode.has()
              end,
              color = Util.fg("Constant")
            },
            -- stylua: ignore
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = Util.fg("Debug")
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = Util.fg("Special")
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed
              }
            }
          },
          lualine_y = {
            {
              "progress",
              separator = " ",
              padding = {
                left = 1,
                right = 0
              }
            },
            {
              "location",
              padding = {
                left = 0,
                right = 1
              }
            }
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end
          }
        },
        extensions = {
          "neo-tree",
          "lazy"
        }
      }
    end
  },
  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = {
      "BufReadPre",
      "BufNewFile"
    },
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = {
        try_as_border = true
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm"
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end
      })
    end
  },

  -- lsp symbol navigation for lualine
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("lazyvim.util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = require("lazyvim.config").icons.kinds
      }
    end
  },

  -- icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true
  },

  -- ui components
  {
    "MunifTanjim/nui.nvim",
    lazy = true
  }
}
