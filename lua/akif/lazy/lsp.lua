return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-buffer",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            -- Mason setup
            require("mason").setup()

            -- Ensure servers are installed
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "eslint",
                    "gopls",
                    "rust_analyzer",
                    "lua_ls",
                    "clangd",
                    "bashls",
                },

                handlers = {
                    function(server_name)
                        local lspconfig = require("lspconfig")
                        local capabilities = require("cmp_nvim_lsp").default_capabilities()

                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                            on_attach = function(_, bufnr)
                                local map = vim.keymap.set
                                local opts = { buffer = bufnr }
                                map("n", "gd", vim.lsp.buf.definition, opts)
                                map("n", "K", vim.lsp.buf.hover, opts)
                                map("n", "<leader>rn", vim.lsp.buf.rename, opts)
                                map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                                map("n", "[d", vim.diagnostic.goto_prev, opts)
                                map("n", "]d", vim.diagnostic.goto_next, opts)
                            end,
                        })
                    end,

                    clangd = function()
                        require("lspconfig").clangd.setup({
                            cmd = {
                                "clangd",
                                "--background-index",
                                "--clang-tidy",
                                "--completion-style=detailed",
                                "--header-insertion=never",
                                "--cross-file-rename=true",
                            },
                            capabilities = require("cmp_nvim_lsp").default_capabilities(),
                            on_attach = function(_, bufnr)
                                local map = vim.keymap.set
                                local opts = { buffer = bufnr }
                                map("n", "gd", vim.lsp.buf.definition, opts)
                                map("n", "K", vim.lsp.buf.hover, opts)
                                map("n", "<leader>rn", vim.lsp.buf.rename, opts)
                                map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                                map("n", "[d", vim.diagnostic.goto_prev, opts)
                                map("n", "]d", vim.diagnostic.goto_next, opts)
                            end,
                        })
                    end,
                }

            })

            -- Disable diagnostic signs
            vim.diagnostic.config({
                signs = false,
            })
        end,
    },

    -- CMP setup
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                },
            })
        end,
    },
}
