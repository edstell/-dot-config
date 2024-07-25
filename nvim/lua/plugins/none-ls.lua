return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- Formatting for Go
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.goimports,
                -- Formatting for Lua files.
                null_ls.builtins.formatting.stylua,

                -- Formatting for javascript files.
                null_ls.builtins.formatting.prettier,
                -- Linting for javascript files.
                null_ls.builtins.diagnostics.erb_lint,
            },
        })

        -- Manually format files (we've also configured formatting on write with the lsp).
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
