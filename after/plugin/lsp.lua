local lsp_zero = require('lsp-zero')


-- Configure keymaps
lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set({ "i", "n" }, "<C-s>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- disable diagnostic signs
vim.diagnostic.config({
    signs = false
})


-- don't add this function in the `on_attach` callback.
-- `format_on_save` should run only once, before the language servers are active.

-- don't format on save, instead format on keymap
--lsp_zero.format_mapping("<leader>fo", {
lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['ts_ls'] = { 'javascript', 'typescript' },
        ['pyright'] = { 'python' },
        ['gopls'] = { 'go' },
        ['lua_ls'] = { 'lua' },
        ["rust_analyzer"] = { 'rust' },
        -- ["clangd"] = { 'c', 'cpp' },
    }

})


-- Mason setup
require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { "gopls", "eslint", "ts_ls", "lua_ls", "pyright", "rust_analyzer", "clangd", "bashls" },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})

require('lspconfig').clangd.setup({
    cmd = { "clangd", "--background-index", "--clang-tidy" }, -- Enable clang-tidy if not already
    on_attach = function(client, bufnr)
        -- Existing key mappings
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set({ "i", "n" }, "<C-s>", function() vim.lsp.buf.signature_help() end, opts)
    end,
})


-- Cmp setup
-- local cmp = require('cmp')
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
--
-- require('luasnip.loaders.from_vscode').lazy_load()
-- cmp.setup({
--     snippet = {
--         expand = function(args)
--             require('luasnip').lsp_expand(args.body)
--         end,
--     },
--     mapping = cmp.mapping.preset.insert({
--         ['<CR>'] = cmp.mapping.confirm({ select = true }),
--         ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--         ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--         ['<C-Space>'] = cmp.mapping.complete(),
--
--         -- scroll up and down the documentation window
--         ['<C-u>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-d>'] = cmp.mapping.scroll_docs(4),
--     }),
--     sources = cmp.config.sources({
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' },
--     }, {
--         { name = 'buffer' }
--     }),
--
-- })