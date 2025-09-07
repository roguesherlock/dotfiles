return {
  "Owen-Dechow/videre.nvim",
  cmd = "Videre",
  dependencies = {
    -- "Owen-Dechow/graph_view_yaml_parser", -- Optional: add YAML support
    -- "Owen-Dechow/graph_view_toml_parser", -- Optional: add TOML support
    -- "a-usr/xml2lua.nvim", -- Optional | Experimental: add XML support
  },
  opts = {
    round_units = false,
    simple_statusline = true, -- If you are just starting out with Videre,
    --   setting this to `false` will give you
    --   descriptions of available keymaps.
  },
}
