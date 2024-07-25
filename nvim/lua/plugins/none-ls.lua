return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- Formatting for Lua files.
                null_ls.builtins.formatting.stylua,

                -- Formatting for javascript files.
                null_ls.builtins.formatting.prettier,
                -- Linting for javascript files.
                null_ls.builtins.diagnostics.erb_lint,
            },
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
