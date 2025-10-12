return {
    { "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {},
    },

    { "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
        opts = {
            ensure_installed = {
                "eslint",
                "gopls",
                "rust_analyzer",
                "lua_ls",
                "clangd",
                "bashls",
            },
        },
    },

    { "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local cmp_lsp = require("cmp_nvim_lsp")

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )

            vim.lsp.config('*', {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    -- general on_attach logic (keymaps etc...)
                end,
            })

            vim.lsp.config('clangd', {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--completion-style=detailed",
                    "--header-insertion=never",
                    "--cross-file-rename=true",
                },
            })

            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                    },
                },
            })

            vim.lsp.config('basedpyright', {
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = "strict",
                            diagnosticSeverityOverrides = {
                                reportAny = false,
                                reportMissingTypeArgument = false,
                                reportMissingTypeStubs = false,
                                reportUnknownArgumentType = false,
                                reportUnknownMemberType = false,
                                reportUnknownParameterType = false,
                                reportUnknownVariableType = false,
                                reportUnusedCallResult = false,
                                reportArgumentType = false,
                                reportUnreachable = false,
                            },
                        },
                    },
                    python = {},
                },
            })

            vim.diagnostic.config({ signs = false })
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
