return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
    'dapc11/telescope-yaml.nvim',
  },
  opts={
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown({previewer = false, winblend = 20,}), },
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
      },
    },
    pcall(require('telescope').load_extension, 'fzf'),
    pcall(require('telescope').load_extension, 'ui-select'),
    pcall(require('telescope').load_extension, 'telescope-yaml'),
  },
}

-- return {
-- {
--   'nvim-telescope/telescope.nvim',
--   tag = '0.1.8',
--   -- event = 'VimEnter',
--   -- main = 'telescope',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     'nvim-tree/nvim-web-devicons',
--   },
--   opts={
--     extensions = {
--       ['ui-select'] = { require('telescope.themes').get_dropdown({previewer = false, winblend = 20,}), },
--       fzf = {
--         fuzzy = true,                    -- false will only do exact matching
--         override_generic_sorter = true,  -- override the generic sorter
--         override_file_sorter = true,     -- override the file sorter
--         case_mode = "smart_case",        -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
--       },
--     },
--     -- Enable Telescope extensions if they are installed
--     pcall(require('telescope').load_extension, 'fzf'),
--     pcall(require('telescope').load_extension, 'ui-select')
--     -- require('telescope').load_extension('fzf'),
--     -- require('telescope').load_extension('ui-select')
--   },
-- --  keys = {
-- --    {'<leader>ff', telescope.builtin.find_files, desc='Telescope find files' },
-- --    {'<leader>fg', telescope.builtin.live_grep, desc='Telescope live grep' },
-- --    {'<leader>fb', telescope.builtin.buffers, desc='Telescope buffers' },
-- --    {'<leader>fh', telescope.builtin.help_tags, desc='Telescope help tags' },
-- --  },
-- --  config = function()
-- --    local builtin = require('telescope.builtin')
-- --    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- --    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- --  end
-- },
-- {
--   'nvim-telescope/telescope-ui-select.nvim',
-- },
-- {
--   'nvim-telescope/telescope-fzf-native.nvim', build = 'make',
--     cond = function()
--       return vim.fn.executable 'make' == 1
--     end,
-- },
-- }
