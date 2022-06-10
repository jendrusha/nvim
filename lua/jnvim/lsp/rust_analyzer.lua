return {
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
		["rust-analyzer"] = {
			assist = {
				importEnforceGranularity = true,
				importPrefix = "crate"
			},
			cargo = {
				allFeatures = true,
			},
			checkOnSave = {
				command = "clippy"
			},
			inlayHints = {
				lifetimeElisionHints = {
					enable = true,
					useParameterNames = true
				},
			},
		}
	}
}
