local api = vim.api
local util = require 'lspconfig/util'
local global = require 'core.global'
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function _G.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end

function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = true,
    signs = {
      enable = true,
      priority = 20
    },
    -- Disable a feature
    update_in_insert = false,
})

lspconfig.pylsp.setup{}


lspconfig.gopls.setup {
  cmd = {"gopls","--remote=auto"},
  -- on_attach = enhance_attach,
  capabilities = capabilities,
  init_options = {
    usePlaceholders=true,
    completeUnimported=true,
  }
}

lspconfig.sumneko_lua.setup {
  cmd = {
    global.home.."/workstation/lua-language-server/bin/macOS/lua-language-server",
    "-E",
    global.home.."/workstation/lua-language-server/main.lua"
  };
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {"vim","packer_plugins"}
      },
      runtime = {version = "LuaJIT"},
      workspace = {
        library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true},{}),
      },
    },
  }
}


lspconfig.tsserver.setup {
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  };
}


lspconfig.jsonls.setup{}
lspconfig.cssls.setup{}
lspconfig.html.setup{}
lspconfig.hls.setup{}
lspconfig.svelte.setup{}
