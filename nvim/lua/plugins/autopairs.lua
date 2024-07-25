-- Automatically add closing braces etc.
return {
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true, -- enable treesitter integration
            disable_filetype = { "TelescopePrompt", "vim" }, -- disable for specific filetypes
        })

        -- If using nvim-cmp for completion, integrate with nvim-autopairs
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
