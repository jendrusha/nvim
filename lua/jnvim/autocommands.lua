vim.api.nvim_create_augroup("Init", { clear = false })
vim.api.nvim_create_autocmd("TextYankPost", {
		group = "Init",
    pattern = "*",
    callback = function()
				vim.highlight.on_yank({ higroup="IncSearch", timeout=150, on_visual=false })
    end,
})
vim.api.nvim_create_autocmd("FocusLost", {
		group = "Init",
    pattern = "*",
    callback = function()
      -- vim.cmd [[ silent! :wa | lua vim.notify(" File saved! ") ]]
      vim.cmd [[ silent! :wa | lua print(" File saved!") ]]
    end,
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
		group = "Init",
    pattern = "*",
    callback = function()
      -- vim.notify("File changed on disk. Buffer reloaded.", "info", { title="Nvim" })
      print("File changed on disk. Buffer reloaded.")
    end,
})
vim.api.nvim_create_autocmd("BufEnter", {
		group = "Init",
    pattern = "~/.config/nvim/*.lua",
    callback = function()
      vim.cmd [[ set foldmethod=marker foldlevel=0 foldenable ]]
    end,
})
vim.api.nvim_create_autocmd("VimEnter", {
		group = "Init",
    pattern = "*",
    callback = function()
      require("funcs.nvim").vim_on_enter()
    end,
})

vim.api.nvim_create_user_command(
  'SessionSave',
  function(input)
		local args = SPLIT_STR(input.args)
		local session_name = "current"

		if #args > 0 then
			session_name = args[1]
		end

		require("funcs.nvim").session_save(session_name)
  end,
  {
		bang = false,
		nargs = "*",
		desc = 'Session - save a session in current working directory'
	}
)

vim.api.nvim_create_user_command(
  'SessionLoad',
  function(input)
		local args = SPLIT_STR(input.args)
		local session_name = "current"

		if #args > 0 then
			session_name = args[1]
		end

		require("funcs.nvim").session_load(session_name)
  end,
  {
		bang = false,
		nargs = "*",
		desc = 'Session - load a session from current working directory'
	}
)
