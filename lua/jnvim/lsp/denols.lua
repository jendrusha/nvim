local util = require('lspconfig.util')
return {
    autostart = false,
    cmd = { "deno", "lsp" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    init_options = {
      enable = true,
      lint = false,
      unstable = false
    },
    root_dir = function(fname)
      return util.root_pattern 'tsconfig.json'(fname)
        or util.root_pattern('package.json', 'jsconfig.json', '.git')(fname)
    end,
}
