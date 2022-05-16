local nvim_lsp = require("lspconfig")

local on_attach = function(_, bufnr)
  print(" LSP started.")
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  MAP('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
  MAP('n', 'gD', "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>")
  MAP('n', 'gi', "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>")
  MAP('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
  MAP('n', 'gI', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  MAP('n', '<space>a', "<cmd>lua vim.lsp.buf.code_action()<CR>")
  MAP('n', '<m-a>', "<cmd>lua vim.lsp.buf.code_action()<CR>")
  MAP('n', '<space>A', '<cmd>lua vim.lsp.buf.rename()<CR>')
  MAP('n', '<m-r>', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
  MAP('n', '<m-R>', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>")
  MAP('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  -- MAP('n', '<space>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
	-- MAP('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  MAP('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 3000)<CR>')
  MAP('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_prev({severity_limit = "Warning", popup_opts = {border = "single"}})<CR>')
  MAP('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_next({severity_limit = "Warning", popup_opts = {border = "single"}})<CR>')
  MAP("n", "<leader>D", "<cmd>Telescope diagnostics<cr>")
  MAP("n", "<space>d", "<cmd>Telescope diagnostics bufnr=0<cr>")

	-- if client.resolved_capabilities.document_highlight then
    -- AUBUF({
      -- {'CursorHold <buffer>', 'lua vim.lsp.buf.document_highlight()'},
      -- {'CursorHoldI <buffer>', 'lua vim.lsp.buf.document_highlight()'},
      -- {'CursorMoved <buffer>', 'lua vim.lsp.buf.clear_references()'},
    -- }, 'highlight')
  -- end

	vim.api.nvim_create_augroup("LspDagnostics", { clear = false })
	vim.api.nvim_create_autocmd("InsertEnter", {
		group = "LspDagnostics",
		pattern = "*",
		callback = function()
			vim.diagnostic.disable()
		end,
	})
	vim.api.nvim_create_autocmd("InsertLeave", {
		group = "LspDagnostics",
		pattern = "*",
		callback = function()
			vim.diagnostic.enable()
		end,
	})
	vim.api.nvim_create_autocmd("CursorHold", {
		group = "LspDagnostics",
		buffer = 0,
		callback = function()
			vim.diagnostic.open_float(0, {focusable = false, scope = "line", source = "always"})
		end,
	})

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      signs = true,
      virtual_text = false,
      underline = true,
      update_in_insert = true,
    }
  )
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      border = 'single'
    }
  )
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signatureHelp, {
      border = 'single'
    }
  )

	-- If you want icons for diagnostic errors, you'll need to define them somewhere:
	-- vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
	-- vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
	-- vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
	-- vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})
	CMD [[
		hi DiagnosticSignError guibg=red guifg=white gui=italic cterm=italic
		hi DiagnosticSignWarn guibg=orange guifg=white gui=italic cterm=italic
		hi DiagnosticSignInfo guibg=grey guifg=white gui=italic cterm=italic
		hi DiagnosticSignHint guibg=blue guifg=white gui=italic cterm=italic
	]]
	vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError", numhl="", linehl="" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn", numhl="", linehl="" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo", numhl="", linehl="" })
	vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint", numhl="", linehl="" })
end

require("jnvim.lsp.treesitter").setup()
require("diagnosticls-configs").setup(require("jnvim.lsp.diagnosticls-configs"))
-- available LSP servers
-- "ccls", "gopls", "intelephense", "sumneko_lua", "tsserver", "denols",
-- "rust_analyzer", "bashls", "dockerls",
local lsp_servers = {
  "gopls", "intelephense", "sumneko_lua", "bashls", "ccls",
}
for _, srv in ipairs(lsp_servers) do
  nvim_lsp[srv].setup(vim.tbl_extend("force", require("jnvim.lsp."..srv), {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
    },
  }))
end

