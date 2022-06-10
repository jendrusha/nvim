local M = {}

M.load_options = function()
  -- Make compatible with st, truecolors
  vim["&t_8f"] = "\\<Esc>[38;2;%lu;%lu;%lum"
  vim["&t_8b"] = "\\<Esc>[48;2;%lu;%lu;%lum"

	vim.g.python3_host_prog = "/usr/bin/python3"
	vim.g.python_host_prog = "/usr/bin/python2"

  local options = {
    encoding = "utf-8",
    mouse = "a",
    foldexpr = "",
    hidden = true,
    number = true,
    hlsearch = false,
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
    smartindent = true,
    completeopt = { "menu", "menuone", "noinsert", "noselect" },
    wildignorecase = true,
    wildmode = { "longest", "full", "full" },
    ignorecase = true,
    conceallevel = 0,
    concealcursor = "vin",
    cursorline = true,
    cursorlineopt = "number",
    pumheight = 15,
    scrolloff = 8,
    scrolljump = 8,
    sidescrolloff = 8,
    updatetime = 200,
		timeoutlen = 300,
    undofile = true,
		undodir = string.format("%s/.vim-history", os.getenv('HOME')),
    splitbelow = true,
    splitright = true,
    swapfile = false,
    signcolumn = "yes:1",
    showmode = false,
		termguicolors = true,
		backup = false,
		writebackup = false,
		confirm = true,
		clipboard = "unnamedplus",
		fillchars = { horiz = '━', horizup = '┻', horizdown = '┳', vert = '.', vertleft = '┫', vertright = '┣', verthoriz = '╋', },
  }

  vim.opt.shortmess:append "c"
  vim.opt.whichwrap:append "<,>,[,],h,l"


  vim.cmd [[set formatoptions-=cro]]

  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

return M
