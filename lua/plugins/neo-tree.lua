return {
  "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "saifulapm/neotree-file-nesting-config", --Vscode like File Nesting
    -- Optional image support for file preview: See `# Preview Mode` for more information.
    -- {"3rd/image.nvim", opts = {}},
    -- OR use snacks.nvim's image module:
    -- "folke/snacks.nvim",
  },
  keys = {
    {'<leader>e', '<cmd>Neotree toggle<CR>', desc = "File Explorer toggle" },
  },
  opts = {
    -- For relative line numbers
    event_handlers = { {
      event = "neo_tree_buffer_enter",
      handler = function() vim.opt_local.relativenumber = true end,
    } },
    -- Show hidden files
    filesystem = { filtered_items = { visible = true, },},
    -- filesystem = {
    --   filtered_items = {
    --     visible = true,
    --     show_hidden_count = true,
    --     hide_dotfiles = false,
    --     hide_gitignored = true,
    --     never_show = {".git"},
    --     hide_by_name = {
    --       -- '.git',
    --       -- '.DS_Store',
    --       -- 'thumbs.db',
    --       -- ".github",
    --       -- ".gitignore",
    --       -- "package-lock.json",
    --       -- ".changeset",
    --       -- ".prettierrc.json",},
    --   },
    -- },

    -- Vscode like File Nesting
    -- hide_root_node = true,
    -- retain_hidden_root_indent = true,
    -- filesystem = {
    --   filtered_items = {
    --     show_hidden_count = false,
    --     never_show = { '.DS_Store',
    --     },
    --   },
    -- },
    -- default_component_configs = {
    --   indent = {
    --     with_expanders = true,
    --     expander_collapsed = '',
    --     expander_expanded = '',
    --   },
    -- },
  },
--  config = function()
--    vim.keymap.set('n', '<leader>tre', ':Neotree filesystem reveal left<CR>')
--  end
}
