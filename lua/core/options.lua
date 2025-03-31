local options = {

  -- GENERAL
  timeoutlen = 500,               -- time to wait for a mapped sequence to complete (in milliseconds), 键盘快捷键等待时间
  updatetime = 300,               -- faster completion (4000ms default), 更新检查间隔时间
  swapfile = false,               -- creates a swapfile, 禁止创建 swap 文件
  undofile = true,                -- enable persistent undo
  writebackup = false,            -- if a file is being edited by another program, it is not allowed to be edited, 禁止写入备份文件
  backup = false,           -- 禁止创建备份文件
  confirm = true,           -- 没有保存或文件只读时弹出确认

  -- APPEARANCE
  fileencoding = "UTF-8",         -- the encoding written to a file, 保存文件的时候使用 UTF-8 编码
  encoding = "UTF-8",             -- 当处理文本的时候使用 UTF-8 编码
  -- guifont = "monospace:h17",      -- the font used in graphical neovim applications
  background = "dark",            -- colorschemes that can be light or dark will be made dark, 设置背景为暗色
  termguicolors = true,           -- set term gui colors (most terminals support this), 开启终端真彩色支持
  conceallevel = 0,               -- so that `` is visible in markdown files
  number = true,                  -- set numbered lines, 显示行号
  relativenumber = true,          -- set relative numbered lines, 使用相对行号
  numberwidth = 2,                -- set number column width to 2 {default 4}
  signcolumn = "yes",             -- always show the sign column, otherwise it would shift the text each time, 左侧始终显示符号列
  cursorline = true,              -- highlight the current line, 高亮当前行
  -- colorcolumn = "100",             -- highlight vertical colorcolumn (moved to after/python.lua), 右侧第 100 列显示颜色参考线
  wrap = true,                    -- display lines as one long line, 启用折行
  showbreak = "  ",               -- set indent of wrapped lines
  cmdheight = 1,                  -- space in the neovim command line for displaying messages, 命令行高度
  pumheight = 10,                 -- pop up menu height, 补全菜单高度为 10 行
  wildmenu = true,                -- 显示补全菜单
  -- showmode = false,               -- we don't need to see things like -- INSERT -- anymore
  splitbelow = true,              -- force all horizontal splits to go below current window, 水平分屏默认在下方
  splitright = true,              -- force all vertical splits to go to the right of current window, 垂直分屏默认在右侧
  scrolloff = 999,                  -- minimal number of screen lines to keep above and below the cursor, 光标上下保持 999 行距离，实现类似 Typora 的打字机的效果
  sidescrolloff = 8,              -- minimal number of screen columns either side of cursor if wrap is `false`, 光标左右保持 8 列距离
  -- shortmess = "filnxtToOFc",      -- which errors to suppress
  -- mousemoveevent = true,
  -- shortmess:append "atI",      -- 隐去启动的提示信息

  -- INDENT
  tabstop = 4,                    -- insert 4 spaces for a tab, Tab 键相当于 4 个空格
  shiftwidth = 4,                 -- the number of spaces inserted for each indentation, 自动缩进时移动 4 个空格
  softtabstop = 4,                -- insert 2 spaces for a tab, 编辑时 Tab 键为 4 个空格
  expandtab = true,               -- convert tabs to spaces, Tab 替换为空格
  breakindent = true,             -- tab wrapped lines
  linebreak = true,               -- companion to wrap, don't split words
  backspace = "indent,eol,start", -- allow backspace on indent, end of line or insert mode start position
  smarttab = true,                -- 开启智能 Tab
  shiftround = true,              -- 使用 >> 和 << 移动时对齐到 shiftwidth 的倍数
  cindent = true,                 -- C 文件自动缩进
  autoindent = true,              -- 新行缩进对齐到当前行
  smartindent = true,             -- 开启智能缩进

  -- EDIT
  -- spell = true,                   -- turns on spellchecker, 支持拼写检查
  -- spelllang = { 'en_us', 'cjk' },        -- sets spelling dictionary, 对英文进行拼写检查, 忽略中文的拼写检查
  clipboard = "unnamedplus",      -- allows neovim to access the system clipboard, 使用系统剪贴板
  mouse = "a",                    -- allow the mouse to be used in neovim, 开启鼠标支持
  -- mousescroll = "ver:2,hor:4",    -- change the speed of the scroll wheel
  ignorecase = true,              -- ignore case in search patterns, 搜索时不区分大小写
  smartcase = true,               -- smart case, 搜索包含大写字母时，自动区分大小写
  hlsearch = true,                -- 搜索高亮
  incsearch = true,               -- 输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果
  showmatch = true,               -- 高亮匹配的括号
  virtualedit = "block",          -- vitualblock mode doesn't get stuck at the end of line
  inccommand = "split",           -- shows all inline replacements in split
  autoread = true,                -- 外部文件修改自动加载
  whichwrap = "<,>,[,]",          -- 光标移到行首或行尾时，可跨行移动
  list = false,                   -- 不显示不可见字符
  listchars = "space:·,tab:>-",   -- 空格和 Tab 的显示方式

}

-- turns on all values in options table above
for k, v in pairs(options) do
  vim.opt[k] = v
end
