return {
  "stevearc/conform.nvim",
  opts = {
    -- formatters_by_ft = { -- Configure Formatters for various FileTypes
    --   lua = { "stylua" },
    --   -- Conform will run multiple formatters sequentially
    --   python = { "isort", "black" },
    --   -- You can customize some of the format options for the filetype (:help conform.format)
    --   rust = { "rustfmt", lsp_format = "fallback" },
    --   -- Conform will run the first available formatter
    --   javascript = { "prettierd", "prettier", stop_after_first = true },
    --   terraform = { "terraform_fmt" }, hcl = { "terraform_fmt" }, tf = { "terraform_fmt" },
    -- },
    formatters_by_ft = {
      lua = { "stylua" },
      terraform = { "terraform_fmt" }, hcl = { "terraform_fmt" }, tf = { "terraform_fmt" },
    },

    -- format_on_save = { -- Apply formatting to known ft on save. Below spec will be passed to conform.format() as well.
    --   timeout_ms = 500, -- Abort formatting at timeout and Save File
    --   lsp_format = "fallback",
    -- },
    -- format_on_save = { timeout_ms = 500, lsp_format = "fallback", },
  },
}
