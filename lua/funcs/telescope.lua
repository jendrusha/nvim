local M = {}
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local builtin = require("telescope.builtin")
local themes = require('telescope.themes')

function M.find_files()
  builtin.find_files(
    themes.get_dropdown({
      find_command = {
        "rg", "--no-ignore", "--hidden", "--files",
        "-g", "!.git",
        "-g", "!node_modules",
        "-g", "!bin",
        "-g", "!var/cache",
        "-g", "!legacy/var/cache",
        "-g", "!vendor",
        "-g", "!cache",
        "-g", "!legacy/vendor",
        "-g", "!cmd/server/static",
        "-g", "!target",
        "-g", "!session-*.vim",
      },
      -- prompt_prefix = "> ",
      prompt_prefix = "➜  ",
      previewer = false,
			initial_mode = "insert",
			on_complete = {
				function()
					vim.cmd[[startinsert]]
				end,
		 },
      layout_config = {
        width = 0.6,
      },
    })
  )
end

function M.find_all_files()
  builtin.find_files(
    themes.get_dropdown({
      prompt_prefix = "➜  ",
      previewer = false,
			initial_mode = "insert",
      layout_config = {
        width = 0.6,
      },
    })
  )
end

function M.find_nvim_files()
  builtin.find_files(
    themes.get_dropdown({
      find_command = {
        "rg", "--no-ignore", "--hidden", "--files",
        "-g", "!.git",
        "-g", "!node_modules",
        "-g", "!var/cache",
        "-g", "!spell",
        "-g", "!plugin",
      },
			prompt_title = "\\ Config Files /",
      prompt_prefix = "> ",
      previewer = false,
			initial_mode = "insert",
		  shorten_path = false,
		  cwd = "~/.config/nvim",
      layout_config = {
        width = 0.6,
      },
    })
  )
end

function M.find_buffers()
  builtin.buffers(
    themes.get_dropdown({
      previewer = false,
			initial_mode = "insert",
      layout_config = {
        width = 0.6,
      },
      sort_lastused = true,
    })
  )
end

function M.find_old_files()
  builtin.oldfiles(
    themes.get_dropdown({
      previewer = false,
			initial_mode = "insert",
      layout_config = {
        width = 0.6,
      },
      sort_lastused = true,
    })
  )
end


function M.find_in_nvim_config_files()
  builtin.live_grep({
    prompt_title = "\\ Find in config files /",
    prompt_prefix = "> ",
		initial_mode = "insert",
    cwd = "~/.config/nvim",
    layout_config = {
      width = 0.6,
    },
  })
end

function M.find_in_project()
  builtin.live_grep(
    themes.get_dropdown({
      prompt_title = "\\ Find in project /",
      prompt_prefix = "> ",
			initial_mode = "insert",
      layout_config = {
        width = 0.6,
      },
      layout_strategy = "horizontal",
    })
  )
  -- local input = {"rg", "--line-number", "--column", ""}
  -- local opts = {
  --   prompt_title = "\\ Find in project //",
  --   prompt_prefix = "> ",
  --   layout_strategy = "vertical",
		-- prompt_position = "top",
  --   finder = finders.new_oneshot_job(input),
  --   sorter = sorters.get_generic_fuzzy_sorter(),
  --   theme = themes.get_dropdown({
  --     previewer = true,
  --     layout_config = {
  --       width = 0.6,
  --     },
  --   }),
		-- sorting_strategy = "descending",
  -- }
  -- local picker = pickers.new(opts)
  -- picker:find()
end

function M.read_sessions()
	local dirLookup = function(dir)
		local files = {}
		local p = io.popen('find "'..dir..'" -maxdepth 1 -type f')
		for file in p:lines() do
			if string.find(file, 'session-.+.vim') then
				local res, _ = file:match("(%w+)(.vim)$")
				table.insert(files, res)
			end
		end

		return files
	end

  local enter = function(prompt_bufnr)
    local selected = actions_state.get_selected_entry()
    actions.close(prompt_bufnr)
    local session_path = vim.fn.getcwd() .. "/session-" .. selected[1] .. ".vim"

		vim.cmd(('source %s'):format(vim.fn.fnameescape(session_path)))
		vim.v.this_session = session_path
  end

	local session_files = dirLookup(vim.fn.getcwd())
	if #session_files == 0 then
		print("No session files to read")
		return
	end

	if #session_files == 1 then
    local session_path = vim.fn.getcwd() .. "/session-" .. session_files[1] .. ".vim"
		vim.cmd(('source %s'):format(vim.fn.fnameescape(session_path)))
		vim.v.this_session = session_path
		return
	end

  local default_theme = {
    layout_strategy = "vertical",
    theme = themes.get_dropdown({
      previewer = false,
    }),
  }

  local opts = {
    prompt_title = "\\ Sessions in project //",
    prompt_prefix = "> ",
		prompt_position = "top",
    finder = finders.new_table(session_files),
    sorter = sorters.get_substr_matcher(),
		sorting_strategy = "descending",
		initial_mode = "insert",
		layout_config = {
			width = 0.3,
			height = 0.12 * #session_files,
		},
    attach_mappings = function(_, map)
      map("i", "<CR>", enter)
      return true
    end,
  }

  pickers.new(default_theme, opts):find()
end

function M.write_sessions()
	local dirLookup = function(dir)
		local files = {}
		local p = io.popen('find "'..dir..'" -maxdepth 1 -type f')
		for file in p:lines() do
			if string.find(file, 'session-.+.vim') then
				local res, _ = file:match("(%w+)(.vim)$")
				table.insert(files, res)
			end
		end

		return files
	end

  local enter = function(prompt_bufnr)
    actions.close(prompt_bufnr)
    local session_name = actions_state.get_current_line()
    local selected_line = actions_state.get_selected_entry()
		if selected_line then
			if selected_line[1] ~= "write" then
				session_name = selected_line[1]
			end
		end
    local session_path = vim.fn.getcwd() .. "/session-" .. session_name .. ".vim"
		require("mini.sessions").write(session_path)
  end

	local session_files = dirLookup(vim.fn.getcwd())

  local default_theme = {
    layout_strategy = "vertical",
    theme = themes.get_dropdown({
      previewer = false,
    }),
  }

  local opts = {
    prompt_title = "\\ Sessions in project //",
    prompt_prefix = "> ",
		prompt_position = "top",
    finder = finders.new_table(session_files),
    sorter = sorters.get_substr_matcher(),
		sorting_strategy = "descending",
		layout_config = {
			width = 0.3,
			height = 0.12 * #session_files,
		},
    attach_mappings = function(_, map)
      map("i", "<CR>", enter)
      return true
    end,
  }

  pickers.new(default_theme, opts):find()
end

function M.session_manager()
  local enter = function(prompt_bufnr)
    actions.close(prompt_bufnr)
    local action = actions_state.get_selected_entry()
		if action then
			if action[1] == "write"  then
				M.write_sessions()
			end

			if action[1] == "read"  then
				M.read_sessions()
			end
		end
  end

  local default_theme = {
    layout_strategy = "vertical",
    theme = themes.get_dropdown({
      previewer = false,
    }),
  }

  local opts = {
    prompt_title = "\\ Sessions in project //",
    prompt_prefix = "> ",
		prompt_position = "top",
    finder = finders.new_table({ "read", "write"}),
    sorter = sorters.get_substr_matcher(),
		sorting_strategy = "descending",
		layout_config = {
			width = 0.3,
			height = 0.12 * 2,
		},
    attach_mappings = function(_, map)
      map("i", "<CR>", enter)
      return true
    end,
  }

  pickers.new(default_theme, opts):find()
end

return M
