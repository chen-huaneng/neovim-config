return {
  "williamboman/mason.nvim",
  ft ={ "py", "cpp", "c", "tex", "bib", "h", "cc", "objc", "objcpp", "md" }, -- Specify the supported file types
  dependencies = {
    "williamboman/mason-lspconfig.nvim", -- Used for managing the installation and configuration of LSP servers
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- Used for managing the installation of development tools (such as formatters, linters)
  },

  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- import mason-tool-installer
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",   -- installed packages
          package_pending = "➜",     -- the package being installed
          package_uninstalled = "✗", -- uninstalled package
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "pyright", -- python LSP
        "clangd",  -- cpp LSP
        "codebook", -- markdown LSP
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "clang-format", -- cpp formatter
        "black",    -- python formatter
        "pylint",   -- python linter
        "flake8",     -- Python static analysis
        "bandit",     -- Python security check
        "cpplint",    -- cpp linter
        "markdownlint", -- markdown linter
        "doctoc", -- markdown formatter
      },
    })
  end,
}