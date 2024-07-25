-- Auto-indentation for various file types.
return {
    {
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
        end
    }
}
