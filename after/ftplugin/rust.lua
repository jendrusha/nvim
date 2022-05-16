vim.api.nvim_create_augroup("RustGroup", { clear = true })
vim.api.nvim_create_autocmd({ "CursorMoved", "InsertLeave", "BufEnter", "BufWinEnter", "BufWritePost", "TabEnter" }, {
	group = "RustGroup",
	buffer = 0,
	callback = function()
		require("lsp_extensions").inlay_hints({ prefix = " » ", aligned = true, highlight = "Comment"})
	end,
})
