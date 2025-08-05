local api = vim.api

-- close help, man, qf, lspinfo with 'q'
api.nvim_create_autocmd(
  "FileType",
  {
    pattern = { "man", "help", "qf", "lspinfo" }, -- "startuptime",
    command = "nnoremap <buffer><silent> q :close<CR>",
  }
)

-- Terminal mappings 
--[[
  The set_terminal_keymaps function is defined. In terminal mode, the shortcut key <esc> is mapped to <C-c>, which can be used to quickly exit terminal mode.
  Navigate between different Windows with <C-h>, <C-j>, <C-k>, and <C-l>. When the terminal is opened (TermOpen), set_terminal_keymaps() is automatically called.
  Press <C-w> to exit from Terminal mode to Normal mode.
--]]
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-c>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "term://*" }, -- use term://*toggleterm#* for only ToggleTerm
  command = "lua set_terminal_keymaps()",
})