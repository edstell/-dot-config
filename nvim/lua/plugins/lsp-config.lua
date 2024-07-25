-- Configure our lsp[s].
return {
    {
        -- Manage multiple LSP installations.
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        -- Install LSPs (DAP, linter and formatters).
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            -- Automatically install linters for new file types.
            auto_install = true
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "tsserver",
                    "html",
                }
            })
        end
    },
    {
        -- Configure installed LSPs.
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.tsserver.setup({
                capabilities = capabilities
            })
            lspconfig.html.setup({
                capabilities = capabilities
            })
        end
    }
}
