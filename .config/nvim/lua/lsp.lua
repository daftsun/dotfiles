vim.pack.add {
	{ src = 'https://github.com/neovim/nvim-lspconfig' }
}

vim.lsp.enable('lua_ls')
vim.lsp.enable('ruff')


-- lsp based auto complete
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

-- lsp based formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
