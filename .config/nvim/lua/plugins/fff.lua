return {
  "dmtrKovalenko/fff.nvim",
  enabled = false,
  build = function()
    -- this will download prebuild binary or try to use existing rustup toolchain to build from source
    -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
    require("fff.download").download_or_build_binary()
  end,
  lazy = false,
  opts = {
    layout = {
      prompt_position = "top",
      width = 0.5,
    },
    hl = {
      title = "FloatTitle",
    },
    preview = {
      enabled = false,
    },
  },
  keys = {
    {
      "<leader><leader>",
      function()
        require("fff").find_files()
      end,
      desc = "Find files",
    },
    {
      "gf",
      function()
        require("fff").open_file_under_cursor(function()
          vim.api.nvim_command("winncmd k")
        end)
      end,
      desc = "Find files",
    },
  },
}
