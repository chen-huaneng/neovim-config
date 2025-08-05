return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" }, -- Load the plugin when entering in insert mode or command-line mode
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
    "hrsh7th/cmp-cmdline", -- command-line mode completion
    "petertriho/cmp-git", -- git command completion
    "f3fora/cmp-spell", -- spelling check completion
    "micangl/cmp-vimtex", -- LaTeX completion (VimTeX Plugin)
  },
  config = function()

    local cmp = require("cmp")

    local luasnip = require("luasnip")

------------------------
-- Icon configuration --
------------------------

    local kind_icons = {
      article = "󰧮", -- article type (LaTeX)
      book = "", -- book type (LaTeX)
      incollection = "󱓷", -- collection type (LaTeX)
      Function = "󰊕", -- function
      Constructor = "", -- constructor
      Text = "󰦨", -- plain text
      Method = "", -- method
      Field = "󰅪", -- field/attribute
      Variable = "󱃮", -- variable
      Class = "", -- class
      Interface = "", -- interface
      Module = "", -- module
      Property = "", -- property
      Unit = "", -- unit 
      Value = "󰚯", -- value
      Enum = "", -- enumeration
      Keyword = "", -- keyword
      Snippet = "", -- code snippet
      -- Color = "󰌁", -- color
      Color = "", -- color
      File = "", -- file
      Reference = "", -- reference
      Folder = "", -- folder
      EnumMember = "", --enumeration member
      spell = "",
      -- EnumMember = "",
      Constant = "󰀫", -- constant
      Struct = "",
      -- Struct = "",
      Event = "", -- event
      Operator = "󰘧", -- operator
      TypeParameter = "", -- type parameter
    }
    -- find more here: https://www.nerdfonts.com/cheat-sheet

----------------------
-- Completion logic --
----------------------

    cmp.setup({
      completion = {
        completeopt = "menu,noselect", -- Complete menu behavior (not automatically selected)
        keyword_length = 1, -- At least one character is entered to trigger completion
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Extend the snippet using LuaSnip
        end,
      },

-----------------
-- Key mapping --
-----------------

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }), -- The previous completion item
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }), -- The next completion item
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll up to complete the window
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll down to complete the window
        -- ["<C-n>"] = cmp.mapping.complete(), -- show completion suggestions
        -- ["<C-h>"] = cmp.mapping.abort(), -- close completion window
        -- ["<C-l>"] = cmp.mapping.confirm({ select = false }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Press Enter to confirm completion (no forced selection)

        -- supertab
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          elseif cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function() -- could be: function(fallback) -- OR: function(delete-two-spaces????)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            -- fallback()
          end
        end, { "i", "s" }),
      }),

-----------------------------------
-- Formatting for autocompletion --
-----------------------------------

      formatting = {
        fields = { "kind", "abbr", "menu" }, -- Completed item display fields (type, abbreviation, source)
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind]) -- Kind icons
          vim_item.menu = ({
            vimtex = vim_item.menu,
            luasnip = "[Snippet]",
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            spell = "[Spell]",
            cmdline = "[CMD]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },

--------------------------------
-- Sources for autocompletion --
--------------------------------

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "vimtex" },
        { name = "buffer", keyword_length = 3 }, -- text within current buffer
        { name = "spell",
          keyword_length = 4,
          option = {
              keep_all_entries = false,
              enable_in_context = function()
                  return true -- Always enable spell check
              end
          },
        },
        { name = "path" },
      }),

-------------------------
-- Other configuration --
-------------------------

      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace, -- Replace the current cursor content
        select = false,
      },
      view = {
        entries = 'custom', -- Customize the display method of completion items
      },
      window = {
        completion = cmp.config.window.bordered(), -- Complete the window with a border
        documentation = cmp.config.window.bordered(), -- Documentation window with a border
      },
      performance = {
         trigger_debounce_time = 500,
         throttle = 550,
         fetching_timeout = 80,
      },
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {name = 'buffer'}
      }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {name = 'path'},
        {name = 'cmdline'}
      }
    })

  end,
}