local path = vim.split(package.path, ";")
table.insert(path, "?.lua")
table.insert(path, "lua/?.lua")
table.insert(path, "lua/?/init.lua")

local library = {}
local function add(lib)
  for _, p in pairs(vim.fn.expand(lib, false, true)) do
    p = vim.loop.fs_realpath(p)
    if p ~= nil then
        library[p] = true
    end
  end
end

add("$VIMRUNTIME")
add("~/.luarocks/share/lua/5.4/*")
add("~/apps/emmy-love-api/api/*")
add("~/.config/nvim")
add("~/.local/share/nvim/site/pack/packer/opt/*")
add("~/.local/share/nvim/site/pack/packer/start/*")

-- P(library)

return {
  cmd = {"lua-language-server"},
  on_new_config = function(config, root)
    local libs = vim.tbl_deep_extend("force", {}, library)
    libs[root] = nil
    config.settings.Lua.workspace.library = libs
    return config
  end,
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern('.git', 'main.lua')(fname)
  end,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = path
      },
      completion = {
        callSnippet = "Replace", -- Disable, Both, Replace
        displayContext = 1,
      },
      diagnostics = {
        globals = { "vim", "love", "MAP", "OPT", "P", "R", "RELOAD", "OPTLOCAL", "CMD", "EXEC" }
      },
      workspace = {
        library = library,
        maxPreload = 2000000,
        preloadFileSize = 5000000,
        checkThirdParty = false,
        userThirdParty = {},
      },
      telemetry = { enable = false }
    }
  }
}
