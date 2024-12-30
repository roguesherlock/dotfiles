local M = {}

M.options = {
  transparent = false,
  italic_comments = true,
  bold_keywords = false,
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M
