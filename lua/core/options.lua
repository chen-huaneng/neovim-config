local options = {

  -- GENERAL
  timeoutlen = 500,               -- time to wait for a mapped sequence to complete (in milliseconds), keyboard shortcut waiting time
  updatetime = 300,               -- faster completion (4000ms default), update the inspection interval time
  swapfile = false,               -- creates a swap file
  undofile = true,                -- enable persistent undo
  writebackup = false,            -- if a file is being edited by another program, it is not allowed to be edited
  backup = false,           -- backup file creation
  confirm = true,           -- a confirmation pops up when there is no save or the file is read-only

  -- APPEARANCE
  fileencoding = "UTF-8",         -- the encoding written to a file
  encoding = "UTF-8",             -- UTF-8 encoding is used when processing text
  guifont = "monospace:h17",      -- the font used in graphical neovim applications
  background = "dark",            -- colorschemes that can be light or dark will be made dark
  termguicolors = true,           -- set term gui colors (most terminals support this)
  conceallevel = 0,               -- so that `` is visible in markdown files
  number = true,                  -- show numbered lines
  relativenumber = true,          -- set relative numbered lines
  numberwidth = 2,                -- set number column width to 2 {default 4}
  signcolumn = "yes",             -- always show the sign column, otherwise it would shift the text each time
  cursorline = true,              -- highlight the current line
  wrap = true,                    -- display lines as one long line, enable line breaks
  showbreak = "↪ ",               -- set indent of wrapped lines
  cmdheight = 1,                  -- space in the neovim command line for displaying messages, command line height
  pumheight = 10,                 -- pop up menu height, the height of the completed menu
  wildmenu = true,                -- display the completion menu
  splitbelow = true,              -- force all horizontal splits to go below current window
  splitright = true,              -- force all vertical splits to go to the right of current window
  scrolloff = 999,                  -- minimal number of screen lines to keep above and below the cursor, achieve an effect similar to that of a Typora typewriter

  -- INDENT
  tabstop = 4,                    -- show 4 spaces for a tab
  shiftwidth = 4,                 -- the number of spaces inserted for each indentation
  softtabstop = 4,                -- insert 4 spaces for a tab
  expandtab = true,               -- convert tabs to spaces
  breakindent = true,             -- tab wrapped lines
  linebreak = true,               -- companion to wrap, don't split words
  backspace = "indent,eol,start", -- allow backspace on indent, end of line or insert mode start position
  smarttab = true,                -- automatically adjust the indentation length of the new line based on the indentation of the current line
  shiftround = true,              -- align to multiples of shiftwidth when moving with >> and <<
  autoindent = true,              -- indentation of the new line is aligned to the current line
  smartindent = true,             -- enable universal intelligent indentation

  -- EDIT
  spell = false,                   -- turns on spellchecker
  clipboard = "unnamedplus",      -- allows neovim to access the system clipboard
  mouse = "a",                    -- allow the mouse to be used in neovim
  ignorecase = true,              -- ignore case in search patterns
  smartcase = true,               -- when searching for capital letters, it automatically distinguishes between upper and lower case
  hlsearch = true,                -- search highlighting
  incsearch = true,               -- when entering the search mode, each character input automatically jumps to the first matching result
  showmatch = true,               -- highlight the matching parentheses
  virtualedit = "block",          -- vitualblock mode doesn't get stuck at the end of line
  inccommand = "split",           -- shows all inline replacements in split
  autoread = true,                -- external file modifications are automatically loaded
  whichwrap = "<,>,[,]",          -- when the cursor is moved to the beginning or end of a line, it can be moved across lines
  list = false,                   -- do not display invisible characters
  listchars = "space:·,tab:>-",   -- display methods of spaces and tabs
}

-- turns on all values in options table above
for k, v in pairs(options) do
  vim.opt[k] = v
end
