require('go').setup({
	goimport = 'gopls', -- if set to 'gopls' will use golsp format
	gofmt = 'gopls', -- if set to gopls will use golsp format
	max_line_len = 120,
	tag_transform = false,
	test_dir = '',
	comment_placeholder = '   ',
	lsp_cfg = true, -- false: use your own lspconfig
	lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
	lsp_on_attach = false, -- use on_attach from go.nvim
	dap_debug = true,
	dap_debug_keymap = true, -- set keymaps for debugger
	dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
	dap_debug_vt = true, -- set to true to enable dap virtual text
})

local util = require('lspconfig.util')
local lastRootPath = nil
local gopath = os.getenv("GOPATH")
if gopath == nil then
  gopath = ""
end
local gopathmod = gopath..'/pkg/mod'

return {
	root_dir = function(fname)
		local fullpath = vim.fn.expand(fname, ':p')
		if string.find(fullpath, gopathmod) and lastRootPath ~= nil then
				return lastRootPath
		end
		lastRootPath = util.root_pattern("go.mod", ".git")(fname)
		return lastRootPath
	end,
	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
				}
			}
		}
	},
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				unusedwrite = true,
				fieldalignment = true,
				nilness = true,
				shadow = false,
				useany = true,
			},
			staticcheck = false,
			usePlaceholders = false,
			completeUnimported = true,
			allExperiments = true,
			hoverKind = 'FullDocumentation',
			symbolStyle = 'Package',
		},
	}
}
