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
  init_options = {
		cache = {
			directory = "/tmp/ccls-cache",
		};
	},
}
