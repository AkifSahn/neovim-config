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

-- Disable diagnostic signs
vim.diagnostic.config({
    signs = false
})

-- Configure format on save
lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['ts_ls'] = { 'javascript', 'typescript' },
        ['eslint'] = { 'javascript', 'typescript', 'vue' },
        ['volar'] = { 'vue' },
        ['pyright'] = { 'python' },
        ['gopls'] = { 'go' },
        ['rust_analyzer'] = { 'rust' },
    }
})

-- Mason setup
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "gopls", "eslint", "ts_ls", "lua_ls", "pyright", "rust_analyzer",
        "clangd", "bashls", "volar"
    },
    handlers = {
        -- Default handler for most servers
        function(server_name)
            if server_name ~= "jedi_language_server" and server_name ~= "basedpyright" and server_name ~= "volar" then
                require('lspconfig')[server_name].setup({})
            end
        end,

        -- Custom handler for clangd
        clangd = function()
            require('lspconfig').clangd.setup({
                cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
                filetypes = { "c" },
                init_options = {
                    clangdFileStatus = true,
                },
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                on_attach = function(client, bufnr)
                    local opts = { buffer = bufnr, remap = false }
                    vim.keymap.set("n", "<leader>hs", function() vim.lsp.buf.document_highlight() end, opts)
                end
            })
        end,

        -- Custom handler for tsserver
        ts_ls = function()
            require('lspconfig').ts_ls.setup({
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })
        end,

        -- Custom handler for volar (Vue 3)
        volar = function()
            require('lspconfig').volar.setup({
                filetypes = { "vue" },
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                init_options = {
                    typescript = {
                        tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"
                    }
                }
            })
        end,

        -- Custom handler for pyright
        pyright = function()
            require('lspconfig').pyright.setup({
                filetypes = { "python" },
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "openFilesOnly",
                            typeCheckingMode = "basic",
                            reportMissingImports = "warning",
                            reportUndefinedVariable = "warning",
                            reportUnusedVariable = "none",
                            reportGeneralTypeIssues = "warning",
                            reportOptionalMemberAccess = "warning",
                            reportArgumentType = "none",
                            django = true,
                        },
                    },
                },
            })
        end,

        -- Disable jedi_language_server
        jedi_language_server = function()
            -- Do nothing
        end,

        -- Disable basedpyright
        basedpyright = function()
            -- Do nothing
        end,
    },
})

