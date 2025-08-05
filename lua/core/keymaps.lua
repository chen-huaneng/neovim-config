---------------------
-- Basic name norm --
---------------------

--[[
----------------------keymap---------------------------
  <C-z> which means Ctrl-z, <C-p> for Ctrl-p, and so on
  <CR> which means <Enter>
  <S-m> which means Shift-m
  <A-Left> which means Alt-Left arrow key
  <BS> which means Backspace key
------------------------mode---------------------------
  'n': normal mode
  'x': visual mode
the difference between 'x', 'v' and 's' see: https://vi.stackexchange.com/questions/38859/what-does-mode-x-mean-in-neovim
--]]

---------------------------
-- Define common options --
---------------------------

local opts = {
  noremap = true, -- non-recursive
  silent = true, -- do not show message
}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.g.mapleader = " "

----------------------
-- Built-in mapping --
----------------------

-- Unmappings <C-z> and set to no actions (<nop>) which used to disable these shortcut keys
keymap("n", "<C-z>", "<nop>", opts)

-- Press <Enter> to clear search highlights results
keymap("n", "<CR>", "<cmd>noh<CR>", opts)

-- Press <Shift-m> to open the help documentation for the word at the cursor
keymap("n", "<S-m>", ':execute "help " . expand("<cword>")<cr>', opts)

-- The 'Y' key is remapped to copy to the end of the line, and the 'E' key is mapped to jump to the end of the previous word
keymap("n", "Y", "y$", opts)
keymap("n", "E", "ge", opts)
keymap("v", "Y", "y$", opts)
keymap("v", "E", "ge", opts) -- causes errors with luasnip autocmp

-- <S-h> and <S-l> are used to jump to the beginning and end of a row respectively
keymap("v", "<S-h>", "g^", opts)
keymap("v", "<S-l>", "g$", opts)
keymap("n", "<S-h>", "g^", opts)
keymap("n", "<S-l>", "g$", opts)

-- Use <C-h>, <C-j>, <C-k>, and <C-l> to navigate quickly between windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows width and height with arrows
-- delta: 2 lines
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate between buffers through <TAB> and <S-TAB>
keymap("n", "<TAB>", ":bnext<CR>", opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", opts)

-- Can continuously use <Tab> or <S-Tab> to change the indentation in selection mode
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

--------------------
-- Telescope.nvim --
--------------------

-- Start the find_files function in the Telescope plugin to search for project files
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { remap = true })

------------------
-- Comment.nvim --
------------------

-- Toggle comments <Ctrl-/> line comments used to switch between the current line and the selected area
keymap('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', opts)
keymap('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', opts)

-----------------
-- Copilot.vim --
-----------------

-- Change the shortcut key for accepting Copilot suggestions
vim.keymap.set('i', '<C-R>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
