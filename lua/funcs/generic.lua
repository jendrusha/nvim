local M = {}

function M.toggle_wrap()
  OPT('w', 'breakindent', not vim.wo.breakindent)
  OPT('w', 'linebreak', not vim.wo.linebreak)
  OPT('w', 'wrap', not vim.wo.wrap)
end

return M
