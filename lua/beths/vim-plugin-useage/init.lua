-- Your prefered colorscheme. Neovim comes with some builtin colorschemes that are accessible the same way as any of the color plugins
vim.cmd.colorscheme("zaibatsu")
-- To try other colorscheme, Use the colorschemes command, ie, ":colorscheme wildcharm"
-- My subjective catagorization + ranking of the included colors
-- |----------------------|-----------------|---------------|-------------------|
-- | Cool Dark            | Warm Dark       | High Contrast | Low Contrast      |
-- |----------------------|-----------------|---------------|-------------------|
-- | tokyonight-night     | retrobox        | sorbet        | terafox           |
-- | tokyonight-moon      | gruvbox         | oxocarbon     | kanso-zen         |
-- | nightfox             | vinyl           | carbonfox     | kanso-ink         |
-- | duskfox              | kanagawa-wave   | slate         | habamax           |
-- | sorbet               | slate           | wildcharm     | onedark           |
-- | tokyonight-storm     | kanagawa-dragon | lunaperche    | kanagawa-dragon   |
-- | terafox              | melange         | zaibatsu      | melange           |
-- | catppuccin-mocha     | unokai          | torte         | kanso-mist        |
-- | catppuccin-macchiato | evening         | murphy        | quiet             |
-- | dracula              | desert          | darkblue      | default           |
-- | zaibatsu             |                 | koehler       | catppuccin-frappe |
-- | darkblue             |                 | vim           | dracula-soft      |
-- |                      |                 | elflord       |                   |
-- |                      |                 | pablo         |                   |
-- |                      |                 | industry      |                   |
-- |                      |                 | ron           |                   |
-- |----------------------|-----------------|---------------|-------------------|

-- NeoTree plugin. This keymap is already set in plugins/neo-tree.lua
-- vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal left<CR>')

-- Treesitter plugin
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Telescope plugin
local tele = require("telescope.builtin")
-- tele.find_files avoids hidden and gitignore files. 
-- The lua code below allows us to toggle this behavior with Ctrl+h
-- Credit to Jamestrew https://github.com/nvim-telescope/telescope.nvim/issues/2874#issuecomment-1900967890
local my_find_files
my_find_files = function(opts, no_ignore)
  opts = opts or {}
  no_ignore = vim.F.if_nil(no_ignore, false)
  opts.attach_mappings = function(_, map)
    map({ "n", "i" }, "<C-h>", function(prompt_bufnr) -- <C-h> to toggle modes
      local prompt = require("telescope.actions.state").get_current_line()
      require("telescope.actions").close(prompt_bufnr)
      no_ignore = not no_ignore
      my_find_files({ default_text = prompt }, no_ignore)
    end,{ desc = "Toggle hidden files"})
    return true
  end

  if no_ignore then
    opts.no_ignore = true
    opts.hidden = true
    opts.prompt_title = "Find Files <ALL>"
    tele.find_files(opts)
  else
    opts.prompt_title = "Find Files"
    tele.find_files(opts)
  end
end

vim.keymap.set("n", "<leader>fa", my_find_files) -- you can then bind this to whatever you want
-- Your telescope window controls can be viewed by ? in normal mode and <C-/> in insert mode
vim.keymap.set("n", "<leader>ff", my_find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fy", "<cmd>Telescope telescope-yaml<CR>")
vim.keymap.set("n", "<leader>fg", tele.live_grep, { desc = "[F]ile contents [G]rep" })
vim.keymap.set("n", "<leader>fb", tele.buffers, { desc = "[F]ile [B]uffers" })
-- vim.keymap.set('n', '<leader><leader>', tele.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set("n", "<leader>fh", tele.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", tele.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fs", tele.builtin, { desc = "[F]ind [S]elections of Telescope" })
vim.keymap.set("n", "<leader>fw", tele.grep_string, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fd", tele.diagnostics, { desc = "Search [D]iagnostics" })
vim.keymap.set("n", "<leader>fr", tele.resume, { desc = "Search [R]esume" })
vim.keymap.set("n", "<leader>f.", tele.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>/", function()
  tele.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ winblend = 10, previewer = false }))
end, { desc = "[/] Fuzzily search in current buffer" })
-- Map more keys with more telescope.builtin Pickers found in github

-- LSP plugin.
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Keymaps available in current buffer that has lsp attached",
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    -- simple function that sets the mode, buffer and description for each keymap.
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    -- Rename the variable under your cursor. Most Language Servers support renaming across files, etc.
    map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

    -- Execute a code action, usually your cursor needs to be on top of an error or a suggestion from your LSP for this to activate.
    map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

    -- Find references for the word under your cursor.
    map("grr", tele.lsp_references, "[G]oto [R]eferences")

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map("gri", tele.lsp_implementations, "[G]oto [I]mplementation")

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map("grd", tele.lsp_definitions, "[G]oto [D]efinition")

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map("gO", tele.lsp_document_symbols, "Open Document Symbols")

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map("gW", tele.lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map("grt", tele.lsp_type_definitions, "[G]oto [T]ype Definition")

    map("grl", vim.diagnostic.open_float, "Open Diagnostics in float")

    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
    ---@param client vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer some lsp support methods only in specific files
    ---@return boolean
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has("nvim-0.11") == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})

-- Conform Plugin
-- Format-on-save option is available but disabled in plugins/conform.lua
vim.keymap.set("n", "<leader>=", function() require("conform").format() end, { desc = "Format Current File" })
