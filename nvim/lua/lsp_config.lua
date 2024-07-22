local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local opts = { noremap=true, silent=true }

-- Configure the Go (gopls) language server.
lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
	filetypes = {"go", "gomod"},

	-- Ignore typical project roots which cause gopls to ingest large monorepos.
	root_dir = util.root_pattern("main.go", "README.md", "LICENSE"),

	settings = {
		gopls = {
			-- Don't try to find the go.mod file, otherwise we ingest large monorepos
            buildFlags = {"-tags", "wireinject"},
			expandWorkspaceToModule = false,
			-- memoryMode = "DegradeClosed",
			directoryFilters = {
				"-vendor",
				"-manifests",
			},
		},
	},

    on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

      local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

      if filetype == 'go' then
          vim.cmd [[autocmd BufWritePre <buffer> :lua goimports(2000)]]
      end
    end,
}

-- bufls setup for Protobuf files
lspconfig.bufls.setup {
    cmd = { "bufls", "serve" },
    filetypes = { "proto" },
    root_dir = lspconfig.util.root_pattern("buf.yaml", "buf.json", ".git"),
    settings = {
        buf = {
            -- Customize settings if needed
        },
    },
    on_attach = function(client, bufnr)
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    end,
}
