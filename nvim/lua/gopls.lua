local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

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

    on_attach = on_attach,
}
