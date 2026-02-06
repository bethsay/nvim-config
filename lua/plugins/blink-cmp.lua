return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets', -- optional: provides snippets for the snippet source
    "mikavilpas/blink-ripgrep.nvim", -- optional: Ripgrep source offers matching words from your entire project as completions.
    "moyiz/blink-emoji.nvim", -- optional: An emoji source
  },
  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'enter',
      ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
      -- ['<Tab>'] = { function(cmp) if cmp.snippet_active() then return cmp.snippet_forward() else cmp.select_next() end end, 'fallback' }, -- Untested. Might be useful
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
      ["<C-g>"] = { function() require("blink-cmp").show({ providers = { "ripgrep" } }) end,},
    },
      -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      -- ['<C-e>'] = { 'hide', 'fallback' },
      -- ['<CR>'] = { 'accept', 'fallback' },
      --
      -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
      -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      --
      -- ['<Up>'] = { 'select_prev', 'fallback' },
      -- ['<Down>'] = { 'select_next', 'fallback' },
      -- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      -- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
      --
      -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      --
      -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },

    appearance = { nerd_font_variant = 'mono' },
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 1000, window = { border = 'rounded' } },
      ghost_text = { enabled = true },
      list = { selection = { preselect = false, auto_insert = true, } },  -- list.selection.preselect is false due to confusion when snippet_active
      -- keyword = { range = 'full'},
      -- Default border is none. other options are bold, double, none, rounded, shadow, single, solid,
      -- menu = { border = 'rounded' },
    },
    -- When ghost text is enabled, you may want the menu to avoid overlapping with the ghost text. 
    -- You may provide a custom completion.menu.direction_priority function to achieve this
    --  completion = {
    --   menu = {
    --     direction_priority = function()
    --       local ctx = require('blink.cmp').get_context()
    --       local item = require('blink.cmp').get_selected_item()
    --       if ctx == nil item == nil then return { 's', 'n' } end
    --
    --       local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
    --       local is_multi_line = item_text:find('\n') ~= nil
    --
    --       -- after showing the menu upwards, we want to maintain that direction
    --       -- until we re-open the menu, so store the context id in a global variable
    --       if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
    --         vim.g.blink_cmp_upwards_ctx_id = ctx.id
    --         return { 'n', 's' }
    --       end
    --       return { 's', 'n' }
    --     end,
    --   },
    -- },

    -- When passing parameters, this will show the function signature.
    signature = { enabled = true, window = { border = 'rounded' } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'omni', 'ripgrep', "emoji",},
      providers = {
        -- 👇🏻👇🏻 ripgrep provider config below
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
          opts = {
            debug = false,
            prefix_min_len = 3,
            project_root_marker = ".git",
            fallback_to_regex_highlighting = true,
            toggles = { on_off = nil, debug = nil, },
            backend = {
              use = "ripgrep",
              customize_icon_highlight = true,
              ripgrep = {
                context_size = 5,
                max_filesize = "1M",
                project_root_fallback = true,
                search_casing = "--ignore-case",
                additional_rg_options = {},
                ignore_paths = {},
                additional_paths = {},
              },
            },
          },
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              item.labelDetails = { description = "(rg)", }
            end
            return items
          end,
        },
        -- 👇🏻👇🏻 emoji provider config below
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = {
            insert = true, -- Insert emoji (default) or complete its name
            ---@type string|table|fun():table
            trigger = function()
              return { ":" }
            end,
          },
          should_show_items = function()
            return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              -- By default, enabled for all file-types.
              { "gitcommit", "markdown", "text", },
              vim.o.filetype
            )
          end,
        },
      },
    },
        -- 👇🏻👇🏻 the ripgrep provider config below
        -- ripgrep = {
          -- module = "blink-ripgrep",
          -- name = "Ripgrep",
          -- the options below are optional, some default values are shown
          ---@module "blink-ripgrep"
          ---@type blink-ripgrep.Options
          -- opts = {
            -- the minimum length of the current word to start searching
            -- (if the word is shorter than this, the search will not start)
            -- prefix_min_len = 3,
            --
            -- Specifies how to find the root of the project where the ripgrep
            -- search will start from. Accepts the same options as the marker
            -- given to `:h vim.fs.root()` which offers many possibilities for
            -- configuration. If none can be found, defaults to Neovim's cwd.
            -- Examples:
            -- - ".git" (default)
            -- - { ".git", "package.json", ".root" }
            -- project_root_marker = ".git",
            --
            -- When a result is found for a file whose filetype does not have a
            -- treesitter parser installed, fall back to regex based highlighting
            -- that is bundled in Neovim.
            -- fallback_to_regex_highlighting = true,
            --
            -- Keymaps to toggle features on/off. This can be used to alter
            -- the behavior of the plugin without restarting Neovim. Nothing
            -- is enabled by default. Requires folke/snacks.nvim.
            -- toggles = {
              -- The keymap to toggle the plugin on and off from blink
              -- completion results. Example: "<leader>tg" ("toggle grep")
              -- on_off = nil,
              --
              -- The keymap to toggle debug mode on/off. Example: "<leader>td" ("toggle debug")
              -- debug = nil,
            -- },
            --
            -- backend = {
              -- The backend to use for searching. Defaults to "ripgrep".
              -- Available options:
              -- - "ripgrep", always use ripgrep
              -- - "gitgrep", always use git grep
              -- - "gitgrep-or-ripgrep", use git grep if possible, otherwise
              --   use ripgrep
              -- use = "ripgrep",
              --
              -- Whether to set up custom highlight-groups for the icons used
              -- in the completion items. Defaults to `true`, which means this
              -- is enabled.
              -- customize_icon_highlight = true,
              --
              -- ripgrep = {
                -- For many options, see `rg --help` for an exact description of
                -- the values that ripgrep expects.
                --
                -- The number of lines to show around each match in the preview
                -- (documentation) window. For example, 5 means to show 5 lines
                -- before, then the match, and another 5 lines after the match.
                -- context_size = 5,
                --
                -- The maximum file size of a file that ripgrep should include
                -- in its search. Useful when your project contains large files
                -- that might cause performance issues.
                -- Examples:
                -- "1024" (bytes by default), "200K", "1M", "1G", which will
                -- exclude files larger than that size.
                -- max_filesize = "1M",
                --
                -- Enable fallback to neovim cwd if project_root_marker is not
                -- found. Default: `true`, which means to use the cwd.
                -- project_root_fallback = true,
                --
                -- The casing to use for the search in a format that ripgrep
                -- accepts. Defaults to "--ignore-case". See `rg --help` for
                -- all the available options ripgrep supports, but you can try
                -- "--case-sensitive" or "--smart-case".
                -- search_casing = "--ignore-case",
                --
                -- (advanced) Any additional options you want to give to
                -- ripgrep. See `rg -h` for a list of all available options.
                -- Might be helpful in adjusting performance in specific
                -- situations. If you have an idea for a default, please open
                -- an issue!
                -- Not everything will work (obviously).
                -- additional_rg_options = {},
                --
                -- Absolute root paths where the rg command will not be
                -- executed. Usually you want to exclude paths using gitignore
                -- files or ripgrep specific ignore files, but this can be used
                -- to only ignore the paths in blink-ripgrep.nvim, maintaining
                -- the ability to use ripgrep for those paths on the command
                -- line. If you need to find out where the searches are
                -- executed, enable `debug` and look at `:messages`.
                -- ignore_paths = {},
                --
                -- Any additional paths to search in, in addition to the
                -- project root. This can be useful if you want to include
                -- dictionary files (/usr/share/dict/words), framework
                -- documentation, or any other reference material that is not
                -- available within the project root.
                -- additional_paths = {},
              -- },
            -- },
            --
            -- Show debug information in `:messages` that can help in
            -- diagnosing issues with the plugin.
            -- debug = false,
          -- },
          -- (optional) customize how the results are displayed. Many options
          -- are available - make sure your lua LSP is set up so you get
          -- autocompletion help
          -- transform_items = function(_, items)
            -- for _, item in ipairs(items) do
              -- example: append a description to easily distinguish rg results
              -- item.labelDetails = {
                -- description = "(rg)",
              -- }
            -- end
            -- return items
          -- end,
        -- },
      -- },
      -- keymap = {
        -- 👇🏻👇🏻 (optional) add a keymap to invoke the search manually
        -- ["<c-g>"] = {
          -- function()
            -- require("blink-cmp").show({ providers = { "ripgrep" } })
          -- end,
        -- },
      -- },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
