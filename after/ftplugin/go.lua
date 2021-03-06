OPTLOCAL('expandtab', false)
OPTLOCAL("colorcolumn", 121)

vim.cmd [[ hi! ColorColumn guibg=#bfbfbf ]]

vim.api.nvim_create_augroup("GolangGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "GolangGroup",
	buffer = 0,
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = {only = {"source.organizeImports"}}

		-- vim.lsp.buf.formatting_sync()

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end

		-- vim.lsp.buf_request(0, 'textDocument/documentAction', params)

		vim.cmd("w")
		vim.cmd("GoFmt")
	end
})
