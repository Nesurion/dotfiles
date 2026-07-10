return {
  {
    "jakewvincent/mkdnflow.nvim",
    ft = "markdown",
    opts = {
      links = {
        style = "wiki",
        conceal = true,
      },
      mappings = {
        MkdnFollowLink = { { "n", "v" }, "<CR>" },
        MkdnDestroyLink = false,
      },
    },
  },
}
