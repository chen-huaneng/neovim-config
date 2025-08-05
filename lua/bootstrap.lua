-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Check if lazy.nvim is installed (check if the path exists)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- Define the remote repository address of lazy.nvim
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  -- Clone the path from the repository to the local area
  local out = vim.fn.system({
    "git", 
    "clone", 
    "--filter=blob:none",  -- Optimize cloning speed and only download necessary files
    "--branch=stable",     -- Use the stable branch
    lazyrepo, 
    lazypath
  })
  -- If the clone fails (git returns a non-zero error code)
  if vim.v.shell_error ~= 0 then
    -- Display error messages and debug output
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    -- Wait for the user to press the button and exit
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Add the path of the lazy.nvim plugin manager to the runtime path (rtp) of Neovim
vim.opt.rtp:prepend(lazypath)

-- Initialize the lazy.nvim plugin manager
require("lazy").setup({
  -- Plugin configuration module
  { import = "plugins" },       -- main plugin directory (lua/plugins directory)
  { import = "plugins.lsp" }    -- LSP plugin directory (lua/plugins/lsp directory)
}, {
  -- Configuration options of the plugin manager
  install = {
    colorscheme = { "gruvbox" },  -- Automatically install the gruvbox color theme during installation
  },
  checker = {
    enabled = true,               -- Enables plugins version checking (check for updates)
    notify = false,               -- Does not pop up notifications when an update is detected
  },
  change_detection = {
    notify = false,               -- No notification pops up when the plugin file is changed
  },
  ui = {
    icons = {
      -- Custom UI icons
      cmd = "⌘",            -- command
      config = "🛠",        -- configuration
      event = "📅",         -- event
      ft = "📂",            -- file type
      init = "⚙",          -- initialization shell
      keys = "🗝",          -- keys binding
      plugin = "🔌",        -- plugins
      runtime = "💻",       -- running
      require = "🌙",       -- require invocation
      source = "📄",        -- source file
      start = "🚀",         -- start plugins
      task = "📌",          -- task
      lazy = "💤 ",         -- lazy plugins
    },
  },
})