return {
  "lervag/vimtex",
  init = function()
    -- Viewer settings
    if vim.fn.has('win32') == 1 or (vim.fn.has('unix') == 1 and vim.env.WSLENV) then
      if vim.fn.executable('sioyek.exe') == 1 then
        vim.g.vimtex_view_method = 'sioyek'
        vim.g.vimtex_view_sioyek_exe = 'sioyek.exe'
        vim.g.vimtex_callback_progpath = 'wsl nvim'
      elseif vim.fn.executable('mupdf.exe') == 1 then
        vim.g.vimtex_view_general_viewer = 'mupdf.exe'
      elseif vim.fn.executable('SumatraPDF.exe') == 1 then
        vim.g.vimtex_view_general_viewer = 'SumatraPDF.exe'
      end
    end

    -- Formatting settings
    -- vim.g.vimtex_format_enabled = true             -- Enable formatting with latexindent
    -- vim.g.vimtex_format_program = 'latexindent'

    -- Indentation settings
    vim.g.vimtex_indent_enabled = false            -- Disable auto-indent from Vimtex
    vim.g.tex_indent_items = false                 -- Disable indent for enumerate
    vim.g.tex_indent_brace = false                 -- Disable brace indent

    -- Suppression settings
    vim.g.vimtex_quickfix_mode = 0                 -- Suppress quickfix on save/build
    vim.g.vimtex_log_ignore = {                    -- Suppress specific log messages
      'Underfull',
      'Overfull',
      'specifier changed to',
      'Token not allowed in a PDF string',
    }

    -- Other settings
    vim.g.vimtex_mappings_enabled = false          -- Disable default mappings
    vim.g.tex_flavor = 'latex'                     -- Set file type for TeX files
  end,
}