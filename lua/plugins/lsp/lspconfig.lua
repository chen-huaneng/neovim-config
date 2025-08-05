return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" }, -- Load when opening/creating a new file
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" }, -- Provide LSP completion capability for auto-completion plugins (such as nvim-cmp)
    { "antosha417/nvim-lsp-file-operations", config = true }, -- Automatically handle file operations (such as synchronizing file structures when renaming)
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- used to enable autocompletion (assign to every lsp server config)
    local default = cmp_nvim_lsp.default_capabilities()

    -- change the diagnostic symbols in the sign column (gutter)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "", -- error
          [vim.diagnostic.severity.WARN] = "",  -- warning
          [vim.diagnostic.severity.INFO] = "",  -- information
          [vim.diagnostic.severity.HINT] = "󰠠",  -- hint
        }
      },
      update_in_insert = true,  -- real-time update diagnosis in insertion mode
      underline = true,  -- display error line
    })

    -- configure python server
    lspconfig["pyright"].setup({
      capabilities = default, -- enable default capabilities (including completion)
      filetypes = { "python" },  -- only useful to .py file type
    })

    -- configure cpp server
    lspconfig["clangd"].setup({
      capabilities = default, -- enable default capabilities (including completion)
      filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp"}, -- supported file type
      single_file_support = true, -- enable single-file mode (applicable to large-scale projects)
    })
  end,
}