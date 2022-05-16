OPTLOCAL("foldmethod", "indent")
OPTLOCAL("foldlevelstart", 5)
OPTLOCAL("foldlevel", 5)
OPTLOCAL("shiftwidth", 4)
OPTLOCAL("softtabstop", 4)
OPTLOCAL("expandtab", true)
OPTLOCAL("tabstop", 4)
OPTLOCAL("smarttab", true)

vim.api.nvim_create_augroup("PhpGroup", { clear = true })
vim.api.nvim_create_autocmd("CompleteChanged", {
	group = "PhpGroup",
	buffer = 0,
	callback = function() vim.cmd [[ iskeyword+=$ ]] end,
})
vim.api.nvim_create_autocmd("CompleteDone", {
	group = "PhpGroup",
	buffer = 0,
	callback = function() vim.cmd [[ iskeyword-=$ ]] end,
})
