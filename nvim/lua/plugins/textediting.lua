return {
    {
        -- Format comments.
        "tpope/vim-commentary",
    },
    {
        -- Automatically add closing braces etc.
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                -- enable treesitter integration
                check_ts = true,
                -- disable for specific filetypes
                disable_filetype = { "TelescopePrompt", "vim" },
            })

            -- If using nvim-cmp for completion, integrate with nvim-autopairs
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
    {
        -- Auto-indentation for various file types.
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true,
                ensure_installed = {
                    "lua",
                    "javascript",
                    "typescript",
                    "go",
                    "gomod",
                    "proto",
                    "python",
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
