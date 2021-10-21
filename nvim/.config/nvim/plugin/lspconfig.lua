local set_keymaps = function(client, bufnr)
	local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap=true, silent=true }
	map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	map('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

require'cmp'.setup{
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' }
	}
}

local servers = { 'rust_analyzer', 'clangd', 'hls' }

local lspconfig = require'lspconfig'
for _, server in ipairs(servers) do
	lspconfig[server].setup{ on_attach = set_keymaps }
end

