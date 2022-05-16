local M = {}

function M.setup()
  -- it's commented for now as it causes issues with highlight of other languages
  -- require "nvim-treesitter.parsers".get_parser_configs().sql = {
  --   install_info = {
  --     url = "https://github.com/tjdevries/tree-sitter-sql.git",
  --     files = {"src/parser.c"}
  --   },
  --   filetype = "sql",
  --   used_by = {"php", "go"}
  -- }

  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "php", "go", "gomod", "typescript", "javascript", "rust", "dockerfile", "bash",
      "graphql", "json", "html", "lua", "python", "yaml",
    },
    sync_install = false,
    highlight = {
      enable = true,
      custom_captures = {},
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
      disable = {"yaml"},
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    autotag = {
      enable = false,
      filetypes = {"html" , "xml", "php", "vue", "javascript"},
    },
    rainbow = {
      enable = false,
      extended_mode = true,
      max_file_lines = nil,
      colors = {},
      termcolors = {},
    },
  }
end

return M

