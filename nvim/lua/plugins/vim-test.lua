return {
    -- Tooling for running tests within vim.
    "vim-test/vim-test",
    dependencies = {
        -- Allow tests to be run in their own tmux pane.
        "preservim/vimux",
    },
    config = function()
        vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", {})
        vim.keymap.set("n", "<leader>T", ":TestFile<CR>", {})
        vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", {})
        vim.keymap.set("n", "<leader>l", ":TestLast<CR>", {})
        vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", {})
        vim.cmd("let test#strategy = 'vimux'")
    end,
}
