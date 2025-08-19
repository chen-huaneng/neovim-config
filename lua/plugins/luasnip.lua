return {
  "L3MON4D3/LuaSnip",
  -- follow latest release
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  config = function()
    local ls = require("luasnip")

    ls.config.set_config({ -- Setting LuaSnip config
      enable_autosnippets = true, -- Enable autotriggered snippets
      store_selection_keys = "<Tab>", -- Use Tab (or some other key if you prefer) to trigger visual selection
      update_events = "TextChanged, TextChangedI", -- Update text when type
    })

    local nvim_config_path = vim.fn.stdpath("config") -- get neovim configuration path
    -- Lazy-load snippets, i.e. only load when required, e.g. for a given filetype
    require("luasnip.loaders.from_lua").lazy_load({
      paths = nvim_config_path .. "/snippets"
    })

    -- vim.keymap.set({"i"}, "<C-E>", function() ls.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

    -- vim.keymap.set({"i", "s"}, "<C-W>", function()
    --   if ls.choice_active() then
    --     ls.change_choice(1)
    --   end
    -- end, {silent = true})
  end,
}