-- 用于在 Neovim 中查找光标下的单词，具体功能如下：
function SearchWordUnderCursor()
    local word = vim.fn.expand('<cword>') -- 获取光标下的单词
    require('telescope.builtin').live_grep({ default_text = word }) -- 调用 Telescope 插件的 live_grep 功能
end
