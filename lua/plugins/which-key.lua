return {
  "folke/which-key.nvim",
  commit = '*',
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200
  end,
  opts = {
    setup = {
      show_help = true,
      plugins = {
        presets = {
          operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false,      -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false,      -- default bindings on <c-w>
          nav = false,          -- misc bindings to work with windows
          z = false,            -- bindings for folds, spelling and others prefixed with z
          g = false,            -- bindings for prefixed with g
          marks = false,        -- shows a list of your marks on ' and `
          registers = false,    -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = false,    -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 10,   -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
        },
      },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<CR>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      -- triggers = "auto", -- automatically setup triggers
      triggers = { "<leader>" }, -- or specify a list manually
      -- add operators that will trigger motion and text object completion
      -- to enable native operators, set the preset / operators plugin above
      -- operators = { gc = "Comments" },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+",      -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
      },
      window = {
        border = "rounded",       -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
        zindex = 1000,            -- positive value to position WhichKey above other floating windows.
      },
      layout = {
        height = { min = 4, max = 25 },                                             -- min and max height of the columns
        width = { min = 20, max = 50 },                                             -- min and max width of the columns
        spacing = 3,                                                                -- spacing between columns
        align = "left",                                                             -- align columns left, center or right
      },
      ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      triggers_nowait = {
      },
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
      -- disable the WhichKey popup for certain buf types and file types.
      -- Disabled by default for Telescope
      disable = {
        buftypes = {},
        filetypes = {},
      },
    },
    defaults = {
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
      prefix = "<leader>",
      mode = { "n", "v" },
      d = { "<cmd>update! | bdelete!<CR>", "delete buffer" },
      e = { "<cmd>NvimTreeToggle<CR>", "explorer" },
      i = { "<cmd>VimtexTocOpen<CR>", "index" },
      k = {
        function()
          -- Initialize variables
          local filename = vim.fn.expand("%:p")       -- Complete file path
          local basename = vim.fn.expand("%:t:r")     -- File names without extensions
          local filetype = vim.bo.filetype            -- Current file type
          local deleted_files = {}
          local messages = {}

          -- Clean up the compiled products (c/cpp)
          if filetype == "c" or filetype == "cpp" then
            local targets = { ".exe", ".o" }
            for _, ext in ipairs(targets) do
              local file = basename .. ext
              local full_path = vim.fn.fnamemodify(filename, ":h") .. "\\" .. file
              if vim.fn.filereadable(full_path) == 1 then
                os.remove(full_path)
                table.insert(deleted_files, file)
              end
            end
          end

          -- Conditional execution of VimtexClean (LaTeX files only)
          if filetype == "tex" then
            vim.cmd("VimtexClean")  -- Clean up LaTeX auxiliary files
            table.insert(messages, "[LaTeX] already clean auxiliary files.")
          end

          -- Generate feedback information
          if #deleted_files > 0 then
            table.insert(messages, 1, "[Code] already clean compile files:\n" .. table.concat(deleted_files, "\n"))
          end
          if #messages == 0 then
            table.insert(messages, "[Code] no auxiliary file need to clean.")
          end

          -- Show notification
          vim.notify(table.concat(messages, "\n\n"), "info", {
            title = "Clean Auxiliary",
            timeout = 3000
          })
        end,
        "kill aux"
      },
      q = { "<cmd>wa! | qa!<CR>", "quit" },
      r = {
        function()
          local filename = vim.fn.expand("%:p")
          local basename = vim.fn.expand("%:t:r")
          local filetype = vim.bo.filetype
          local cmd = ""
          local quoted_filename = string.format('"%s"', filename) -- Handle paths containing Spaces

          -- Dynamically select operations based on file types
          if filetype == "tex" then
            -- LaTeX file: Triggers VimtexCompile compilation
            vim.cmd("VimtexCompile")
            return
          elseif filetype == "python" then
            cmd = "python " .. quoted_filename
          elseif filetype == "cpp" then
            local exe_name = basename .. ".exe"
            cmd = string.format("g++ %s -o %s && .\\%s", quoted_filename, exe_name, exe_name)
          elseif filetype == "c" then
            local exe_name = basename .. ".exe"
            cmd = string.format("gcc %s -o %s && .\\%s", quoted_filename, exe_name, exe_name)
          else
            vim.notify("unsupported file type: " .. filetype, "error", { title = "Run/Compile" })
            return
          end

          -- Execute the command and display the output
          local output = vim.fn.system(cmd)
          vim.api.nvim_echo({{output, "Normal"}}, false, {})
        end,
        "run code"
      },
      u = { "<cmd>Telescope undo<CR>", "undo history" },
      v = { "<cmd>VimtexView<CR>", "view" },
      w = { "<cmd>wa!<CR>", "write" },
      a = {
        name = "ACTIONS",
        c = { "<cmd>vert sb<CR>", "create split" },
        h = { "<cmd>LocalHighlightToggle<CR>", "local highlight toggle" },
        j = { "<cmd>clo<CR>", "drop split" },
        k = { "<cmd>clo<CR>", "kill split" },
        m = { "<cmd>on<CR>", "max split" },
        r = { "<cmd>VimtexErrors<CR>", "report errors" },
        w = { "<cmd>VimtexCountWords!<CR>", "word count" },
      },
      c = {
        name = "Copilot",
        d = {
          function()
            vim.cmd("Copilot disable")
            vim.notify("[Copilot] Copilot disabled", vim.log.levels.INFO, { title = "Copilot Status" })
          end,
          "disable Copilot"
        },
        e = {
          function()
            vim.cmd("Copilot enable")
            vim.notify("[Copilot] Copilot enabled", vim.log.levels.INFO, { title = "Copilot Status" })
          end,
          "enable Copilot"
        },
      },
      f = {
        name = "FIND",
        b = {
          "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
          "buffers",
        },
        f = { "<cmd>Telescope live_grep theme=ivy<CR>", "project" },
        g = { "<cmd>Telescope git_commits<CR>", "git history" },
        h = { "<cmd>Telescope help_tags<CR>", "help" },
        k = { "<cmd>Telescope keymaps<CR>", "keymaps" },
        r = { "<cmd>Telescope registers<CR>", "registers" },
        w = { "<cmd>lua SearchWordUnderCursor()<CR>", "word" },
        r = { "<cmd>Telescope oldfiles<CR>", "recent" },
      },
      g = {
        name = "GIT",
        b = { "<cmd>Telescope git_branches<CR>", "checkout branch" },
        c = { "<cmd>Telescope git_commits<CR>", "commits" },
        d = { "<cmd>Gitsigns diffthis HEAD<CR>", "diff" },
        k = { "<cmd>Gitsigns prev_hunk<CR>", "prev hunk" },
        j = { "<cmd>Gitsigns next_hunk<CR>", "next hunk" },
        l = { "<cmd>Gitsigns blame_line<CR>", "line blame" },
        p = { "<cmd>Gitsigns preview_hunk<CR>", "preview hunk" },
        t = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "toggle blame" },
      },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts.setup)
    wk.register(opts.defaults)
  end,
}