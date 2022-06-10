-- {{{ [[ plugins list ]]
local plugins = {
	"https://github.com/norcalli/nvim-colorizer.lua",
	"https://github.com/projekt0n/github-nvim-theme",
	"https://github.com/bluz71/vim-moonfly-colors",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/windwp/nvim-autopairs",
	"https://github.com/nvim-treesitter/playground",
	{ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },
	{ "antoinemadec/FixCursorHold.nvim", event = "BufRead" },
  "https://github.com/ttys3/nvim-blamer.lua",
  "https://github.com/editorconfig/editorconfig-vim",
  { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x", requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
  },
  "https://github.com/godlygeek/tabular",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-lua/popup.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/RishabhRD/popfix",
  "https://github.com/nvim-lualine/lualine.nvim",
  { "https://github.com/nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  "https://github.com/p00f/nvim-ts-rainbow",
  "https://github.com/nvim-treesitter/completion-treesitter",
  "https://github.com/ntpeters/vim-better-whitespace",
  "https://github.com/stevearc/dressing.nvim",
	"https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/f3fora/cmp-spell",
  "https://github.com/hrsh7th/cmp-vsnip",
  "https://github.com/hrsh7th/vim-vsnip",
  "https://github.com/hrsh7th/vim-vsnip-integ",
  "https://github.com/hrsh7th/nvim-cmp",
 	{'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'},
  "https://github.com/ray-x/lsp_signature.nvim",
  { "https://github.com/nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/onsails/lspkind-nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/creativenull/diagnosticls-configs-nvim",
  "https://github.com/ray-x/go.nvim",
	"https://github.com/rcarriga/nvim-notify",
	"https://github.com/vim-test/vim-test",
	"https://github.com/simrat39/rust-tools.nvim",
  -- "https://github.com/rafaelsq/nvim-goc.lua",
	'https://github.com/mfussenegger/nvim-dap',
	'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
}
--}}}

-- {{{ [[ bootstrap ]]
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/jnvim/plugins/init.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}
-- }}}
-- {{{ [ plugins loader ]
return packer.startup(function(use)
  use "https://github.com/wbthomason/packer.nvim"

	for _, plugin in ipairs(plugins) do
		use(plugin)
	end
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
-- }}}
