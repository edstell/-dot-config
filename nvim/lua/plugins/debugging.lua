return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            require("dap-go").setup()
            require("dapui").setup()

            -- Automatically open and close debug UI when debugging starts/stops.
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            -- Bind debugging commands.
            vim.keymap.set("n", "<Leader>dc", dap.continue, {})
            vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
            vim.keymap.set("n", "<Leader>dB", dap.set_breakpoint)
        end,
    },
}
