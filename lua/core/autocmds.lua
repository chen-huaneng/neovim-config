local api = vim.api

-- close help, man, qf, lspinfo with 'q' 为 man、help、qf 和 lspinfo 文件类型创建自动命令，按 q 关闭这些窗口，便于查看后快速退出。
api.nvim_create_autocmd(
  "FileType",
  {
    pattern = { "man", "help", "qf", "lspinfo" }, -- "startuptime",
    command = "nnoremap <buffer><silent> q :close<CR>",
  }
)

-- Terminal mappings 
--[[
定义了 set_terminal_keymaps 函数，在终端模式中设置快捷键：<esc> 映射为 <C-c>，可用来快速退出终端模式。
<C-h>, <C-j>, <C-k>, <C-l> 在不同窗口之间导航。当打开终端时（TermOpen），自动调用 set_terminal_keymaps()。
]]
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-c>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "term://*" }, -- use term://*toggleterm#* for only ToggleTerm
  command = "lua set_terminal_keymaps()",
})

-- Autolist markdown mappings
--[[
在 Markdown 文件中自动设置键映射，用于管理有序或无序列表：
<CR>、o、O 用于插入新列表项。
<tab>、<S-tab> 在插入模式下重新计算列表缩进。
dd、d 删除列表项并重新计算。
设置 tabstop、shiftwidth 和 softtabstop 为 2 个空格，符合 Markdown 语法要求。
]]
function _G.set_markdown_keymaps()
  vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "n", "o", "o<cmd>AutolistNewBullet<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "n", "O", "O<cmd>AutolistNewBulletBefore<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "i", "<tab>", "<Esc>><cmd>AutolistRecalculate<cr>a<space>", {})
  vim.api.nvim_buf_set_keymap(0, "i", "<S-tab>", "<Esc><<cmd>AutolistRecalculate<cr>a", {})
  vim.api.nvim_buf_set_keymap(0, "n", "dd", "dd<cmd>AutolistRecalculate<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "v", "d", "d<cmd>AutolistRecalculate<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "n", ">", "><cmd>AutolistRecalculate<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "n", "<", "<<cmd>AutolistRecalculate<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "n", "<C-c>", "<cmd>AutolistRecalculate<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "n", "<C-n>", "<cmd>lua HandleCheckbox()<CR>", {})
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPre", "BufNewFile" }, {
  pattern = { "*.md" },
  command = "lua set_markdown_keymaps()",
})
