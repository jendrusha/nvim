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

local gopath = os.getenv("GOPATH")
if gopath == nil then
  gopath = ""
end

return {
	-- https://github.com/ray-x/go.nvim/blob/0fe0a9ee3367f7bd1e9c9ab30d5b7d5e66b83fc6/lua/go/gopls.lua#L117-L181
	root_dir = function(fname)
    local has_lsp, lspconfig = pcall(require, "lspconfig")
    if has_lsp then
      local util = lspconfig.util
      return util.root_pattern("go.mod", ".git")(fname) or util.path.dirname(fname)
    end
  end,
	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					commitCharactersSupport = true,
          deprecatedSupport = true,
          documentationFormat = { "markdown", "plaintext" },
          preselectSupport = true,
          insertReplaceSupport = true,
          labelDetailsSupport = true,
          snippetSupport = true,
          resolveSupport = {
            properties = {
              "documentation",
              "details",
              "additionalTextEdits",
            },
          },
				}
			},
			contextSupport = true,
      dynamicRegistration = true,
		}
	},
	filetypes = { "go", "gomod", "gohtmltmpl", "gotexttmpl" },
  message_level = vim.lsp.protocol.MessageType.Error,
	cmd = {
    "gopls", -- share the gopls instance if there is one already
    "-remote.debug=:0",
  },
	flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				unusedwrite = true,
				fieldalignment = true,
				nilness = true,
				shadow = false,
				useany = true,
				unreachable = false,
			},
			staticcheck = true,
			usePlaceholders = false,
			completeUnimported = true,
			allExperiments = true,
			matcher = "Fuzzy",
      diagnosticsDelay = "500ms",
      experimentalWatchedFileDelay = "100ms",
      symbolMatcher = "fuzzy",
			experimentalPostfixCompletions = true,
      experimentalUseInvalidMetadata = true,
      hoverKind = "FullDocumentation",
			-- symbolStyle = 'Package',
			["local"] = "",
      gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
      buildFlags = { "-tags", "integration" },
		},
	}
}
