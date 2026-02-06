return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master', lazy = false, build = ":TSUpdate",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", },
  --nvim-treesitter plugin does not support lazy-loading. But it might
  --Make sure to specify the master branch for nvim-treesitter, as the default branch will switch to main in the future.
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "json", "yaml", "terraform", "hcl" },
    highlight = { enable = true },
    indent = { enabled = true },
    incremental_selection = { enable = true,
      keymaps = {
        init_selection = false, -- set to `false` to disable one of the mappings.
        node_incremental = "n", -- vn, ie press n in Visual mode
        scope_incremental = false,
        node_decremental = "N", -- vN, ie press N in Visual mode
      },
    },
    textobjects = {
      select = { enable = false, lookahead = true, include_surrounding_whitespace = false,
        keymaps = {
          ["ac"] = "@comment.outer",
          ["ic"] = "@comment.inner",
        },
        selection_modes = {},
      },
      move = { enable = false, set_jumps = true,
        goto_next_start = {},
        goto_next_end = {},
        goto_previous_start = {},
        goto_previous_end = {},
      },
    },
  },
}

--  Try the commands :Inspect and :InspectTree
--  +---------------------+-----------------+
--  |   Query             |  Languages      |
--  +---------------------+-----------------+
--  |  @assignment.inner  |  lua yaml bash  |
--  |  @assignment.lhs    |  lua yaml bash  |
--  |  @assignment.outer  |  lua yaml bash  |
--  |  @assignment.rhs    |  lua yaml bash  |
--  |  @attribute.inner   |                 |
--  |  @attribute.outer   |                 |
--  |  @block.inner       |  lua            |
--  |  @block.outer       |  lua            |
--  |  @call.inner        |  lua            |
--  |  @call.outer        |  lua            |
--  |  @class.inner       |                 |
--  |  @class.outer       |                 |
--  |  @comment.inner     |  lua yaml bash  |
--  |  @comment.outer     |  lua yaml bash  |
--  |  @conditional.inner |  lua      bash  |
--  |  @conditional.outer |  lua      bash  |
--  |  @frame.inner       |                 |
--  |  @frame.outer       |                 |
--  |  @function.inner    |  lua      bash  |
--  |  @function.outer    |  lua      bash  |
--  |  @loop.inner        |  lua      bash  |
--  |  @loop.outer        |  lua      bash  |
--  |  @number.inner      |  lua yaml bash  |
--  |  @parameter.inner   |  lua      bash  |
--  |  @parameter.outer   |  lua            |
--  |  @regex.inner       |           bash  |
--  |  @regex.outer       |                 |
--  |  @return.inner      |  lua            |
--  |  @return.outer      |  lua            |
--  |  @scopename.inner   |                 |
--  |  @statement.outer   |  lua yaml       |
--  +---------------------+-----------------+
