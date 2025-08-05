return {
  "micangl/cmp-vimtex",
  ft = { "tex", "bib", "cls" }, -- Only loaded when .tex .bib .cls files are opened
  config = function()
    require('cmp_vimtex').setup({
      additional_information = {
        info_in_menu = true,
        info_in_window = true,
        info_max_length = 60,
        match_against_info = true,
        symbols_in_menu = true,
      },
      bibtex_parser = {
        enabled = true,
      },
    })
  end,
}