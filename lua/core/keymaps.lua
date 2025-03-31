local opts = { noremap = true, silent = true } -- noremap 禁止递归映射，silent 禁止显示命令。

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
-- local map = vim.keymap.set -- for conciseness

--Remap space as leader key
vim.g.mapleader = " " -- 设置空格为 Leader Key
-- vim.g.maplocalleader = " "


-------------------- General Keymaps --------------------

-- delete single character without copying into register
-- keymap("n", "x", '"_x', opts)
-- keymap("v", "p", '"_p', opts)

-- Unmappings 解绑快捷键,<C-z>、gc、gcc 被设置为无操作（<nop>）,用于禁用这些快捷键。
keymap("n", "<C-z>", "<nop>", opts)
keymap("n", "gc", "<nop>", opts)
keymap("n", "gcc", "<nop>", opts)

-- NOTE: not sure I will uses these cmp-vimtex commands
-- Search from hovering over cmp-vimtex citation completion
-- vim.keymap.set("i", "<C-z>", function() 
--   require('cmp_vimtex.search').search_menu()
-- end)
-- vim.keymap.set("i", "<C-z>", function() 
--   require('cmp_vimtex.search').perform_search({ engine = "arxiv" })
-- end)

-- NOTE: prefer to use whichkey
-- Surround 
-- vim.keymap.set("v", '<C-s>', 'S', { remap = true }) -- see surround.lua


-- Spelling "<C-s>" 调用 telescope 插件的 spell_suggest，提供拼写建议，光标处展示一个小窗口。
vim.keymap.set("n", "<C-s>", function()
  require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({
      previewer = false,
      layout_config = {
        width = 50,
        height = 15,
      }
    })
  )
end, { remap = true })
-- vim.keymap.set("n", "<C-s>", "z=", { remap = true}) 
-- keymap("n", "<C-s>", "<cmd>Telescope spell_suggest<cr>", { remap = true})

-- Kill search highlights 按 <Enter> 清除高亮显示的搜索结果。
keymap("n", "<CR>", "<cmd>noh<CR>", opts)


-- Find project files <Ctrl-p> 启动 Telescope 插件中的 find_files 函数，用于查找项目文件。
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { remap = true })
  -- function ()
  --   require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer = false}))
  -- end, 


-- Toggle comments <Ctrl-/> 用于切换当前行和选择区域的行注释。
keymap('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', opts)
keymap('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', opts)


-- Open help on word 按 <Shift-m> 打开光标处单词的帮助文档。
keymap("n", "<S-m>", ':execute "help " . expand("<cword>")<cr>', opts)


-- Fix 'Y', 'E' Y 键重新映射为复制到行尾，E 映射为跳转到上一个单词结尾。
keymap("n", "Y", "y$", opts)
keymap("n", "E", "ge", opts)
keymap("v", "Y", "y$", opts)
keymap("v", "E", "ge", opts) -- causes errors with luasnip autocmp


-- Better window navigation 使用 <C-h>, <C-j>, <C-k>, <C-l> 快速在窗口间导航。
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)


-- Resize with arrows <A-Left> 和 <A-Right> 用于调整窗口宽度。
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)
-- keymap("n", "<A-h>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<A-l>", ":vertical resize +2<CR>", opts)


-- Navigate buffers <TAB> 和 <S-TAB> 在缓冲区之间切换。
keymap("n", "<TAB>", ":bnext<CR>", opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", opts)
keymap("n", "<BS>", ":BufferLineMoveNext<CR>", opts)
keymap("n", "<S-BS>", ":BufferLineMovePrev<CR>", opts)


-- Drag lines <Alt-j> 和 <Alt-k> 用于拖动行。
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("v", "<A-j>", ":m'>+<CR>gv", opts)
keymap("v", "<A-k>", ":m-2<CR>gv", opts)

-- Horizontal line movments -- <S-h> 和 <S-l> 用于跳到行的开头和结尾。
keymap("v", "<S-h>", "g^", opts)
keymap("v", "<S-l>", "g$", opts)
keymap("n", "<S-h>", "g^", opts)
keymap("n", "<S-l>", "g$", opts)

-- Change Copilot keymap -- 更改接受 Copilot 建议的快捷键
vim.keymap.set('i', '<C-R>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

