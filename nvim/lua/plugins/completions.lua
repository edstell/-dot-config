return {
    {
        -- Source completions from the running lsp for the current buffer.
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        -- LuaSnip provides the the snippets.
        "L3MON4D3/LuaSnip",
        dependencies = {
            -- Used by LuaSnip to actually do the completions.
            "saadparwaiz1/cmp_luasnip",
            -- Source of the snippets which are expanded.
            "rafamadriz/friendly-snippets",
        },
    },
    {
        -- Completion engine.
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            -- Add the snippets from friendly to lua-snippets.
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    -- The function that's run when a snippet is expanded,
                    -- we're using luasnip for this.
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    -- How the window appers (with borders).
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    -- Keybindings for our snippets engine.
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
}
