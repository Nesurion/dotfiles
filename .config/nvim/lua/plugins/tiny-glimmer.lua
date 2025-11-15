return {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  priority = 10, -- Low priority to catch other plugins' keybindings
  config = function()
    require("tiny-glimmer").setup({
      overwrite = {
        search = {
          enabled = true,
        },
        undo = {
          enabled = true,
        },
        redo = {
          enabled = true,
        },
        yank = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = "#9ece6a",
              min_duration = 400,
              max_duration = 600,
            },
          },
        },
      },
    })
  end,
}
