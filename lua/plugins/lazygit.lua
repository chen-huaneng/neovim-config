return {
  "kdheepak/lazygit.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies =  {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require("telescope").load_extension("lazygit")
  end
}
