-- Configure our lsp[s].
return {
    {
        -- Manage multiple LSP installations.
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        -- Install LSPs (DAP, linter and formatters).
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            -- Automatically install linters for new file types.
            auto_install = true,
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "tsserver",
                    "html",
                    "gopls",
                },
            })
        end,
    },
    {
        -- Configure installed LSPs.
        "neovim/nvim-lspconfig",
        config = function()
            -- Export the lsp's capabilities to cmp (completion).
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- Define our bindings which are setup once the lsp attaches to the buffer.
            local on_attach = function(_, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
                vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
                vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
                vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
                vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "<space>wa",
                    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
                    {}
                )
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "<space>wr",
                    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
                    {}
                )
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "<space>wl",
                    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                    {}
                )
                vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {})
                vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
                vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
                vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {})
                vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})

                -- Create an autocmd group for LSP formatting
                vim.api.nvim_create_augroup("LspFormatting", { clear = true })
                -- Set up LSP formatting on save
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = "LspFormatting",
                    pattern = "*",
                    callback = function()
                        -- 1000ms timeout for formatting
                        vim.lsp.buf.format({ timeout_ms = 1000 })
                    end,
                })
            end

            local lspconfig = require("lspconfig")
            lspconfig.gopls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig.tsserver.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end,
    },
}
