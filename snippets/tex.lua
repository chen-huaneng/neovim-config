-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- Example: expanding a snippet on a new line only.
-- In a snippet file, first require the line_begin condition...
-- ...then add `condition=line_begin` to any snippet's context table:
local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Include this `in_mathzone` function at the start of a snippets file...
-- Then include `condition = in_mathzone` to any snippet you want to
-- expand only in math contexts.
local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
--------------------------------------------------
-- Example: use of insert node placeholder text --
--------------------------------------------------
	s({ trig="hr", dscr="The hyperref package's href{}{} command (for url links)" },
	  fmta(
	    [[\href{<>}{<>}]],
	    {
	      i(1, "url"),
	      i(2, "display name"),
	    }
	  )
	),
--------------------------------------------------------
-- Example: italic font implementing visual selection --
--------------------------------------------------------
	s({ trig="tii", dscr="Expands 'tii' into LaTeX's textit{} command." },
	  fmta("\\textit{<>}",
	    {
	      d(1, get_visual),
	    }
	  )
	),
----------------------------------
-- A fun zero subscript snippet --
----------------------------------
	s({ trig='([%a%)%]%}])00', regTrig=true, wordTrig=false, snippetType="autosnippet" },
	  fmta(
	    "<>_{<>}",
	    {
	      f( function(_, snip) return snip.captures[1] end ),
	      t("0")
	    }
	  )
	),
-----------------------------------
-- Snippets for only in new line --
-----------------------------------
	-- HTML-like to insert directory hierarchy
	s({ trig="h1", snippetType="autosnippet", condition=line_begin },
	  fmta(
	    [[\section{<>}]],
	    { d(1, get_visual) }
	  )
	),

	s({ trig="h2", snippetType="autosnippet", condition=line_begin },
	  fmta(
	    [[\subsection{<>}]],
	    { d(1, get_visual) }
	  )
	),

	s({ trig="h3", snippetType="autosnippet", condition=line_begin },
	  fmta(
	    [[\section{<>}]],
	    { d(1, get_visual) }
	  )
	),

	-- Begin new environment
	s({ trig="env", dscr="A generic new environmennt", condition=line_begin },
	  fmta(
	    [[
	      \begin{<>}
	          <>
	      \end{<>}
	    ]],
	    {
	      i(1),
	      i(2),
	      rep(1),
	    }
	  )
	),
------------------------------------
-- Snippets for only in math mode --
------------------------------------
	-- Fraction
	s({ trig = "ff", snippetType="autosnippet", condition=in_mathzone },
	  fmta(
	    "\\frac{<>}{<>}",
	    {
	      i(1),
	      i(2),
	    }
	  )
	),

	-- Greek letter
	s({ trig=";a", snippetType="autosnippet", condition=in_mathzone },
	  {
	    t("\\alpha"),
	  }
	),
	s({ trig=";b", snippetType="autosnippet", condition=in_mathzone },
	  {
	    t("\\beta"),
	  }
	),
	s({ trig=";g", snippetType="autosnippet", condition=in_mathzone },
	  {
	    t("\\gamma"),
	  }
	),
}