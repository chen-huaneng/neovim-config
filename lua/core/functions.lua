-- Used to find the word under the cursor
function SearchWordUnderCursor()
    local word = vim.fn.expand('<cword>') -- get the word under the cursor
    require('telescope.builtin').live_grep({ default_text = word }) -- invoke the live_grep function of the Telescope plugin
end