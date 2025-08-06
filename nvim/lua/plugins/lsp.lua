-- LSP Configuration

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "scalameta/nvim-metals",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "tsserver",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- Metals (Scala) Configuration
        local metals_config = require("metals").bare_config()
        metals_config.settings = {
            showImplicitArguments = true,
            showInferredType = true,
            showImplicitConversionsAndClasses = true,
            excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
            enableSemanticHighlighting = true,
            fallbackScalaVersion = "3.3.4",
            serverVersion = "1.6.1", -- Use stable version instead of snapshot
            bloopVersion = "latest.release",
            -- Scala 3 specific settings
            enableIndentOnPaste = true,
            enableStripMarginOnTypeFormatting = true,
            -- Better test interface (useful for Play's test frameworks)
            testUserInterface = "Code Lenses",
            -- Enable automatic build import for better project setup
            autoImportBuild = true,
        }
        metals_config.capabilities = capabilities
        
        -- Simplify init_options for better compatibility
        metals_config.init_options = {
            statusBarProvider = "on",
            isHttpEnabled = true,
        }
        
        -- Add some debugging
        metals_config.handlers = {
            ["metals/status"] = function(err, result, ctx, config)
                if result then
                    print("Metals status: " .. (result.text or ""))
                end
            end
        }
        
        -- Add Metals-specific commands and keybindings
        metals_config.on_attach = function(client, bufnr)
            print("Metals attached to buffer " .. bufnr .. " with client " .. client.name)
            
            -- Enable hover and signature help
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
            vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { buffer = bufnr, desc = "Workspace symbols" })
            
            -- Only set up codelens if supported
            if client.server_capabilities.codeLensProvider then
                vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { buffer = bufnr, desc = "Code lens" })
                vim.lsp.codelens.refresh()
            end
            
            vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
            
            -- Metals specific commands
            vim.keymap.set("n", "<leader>mt", "<cmd>MetalsTreeViewToggle<cr>", { buffer = bufnr, desc = "Toggle Metals tree view" })
            vim.keymap.set("n", "<leader>mp", "<cmd>MetalsTreeViewReveal<cr>", { buffer = bufnr, desc = "Reveal in Metals tree" })
            vim.keymap.set("n", "<leader>mc", "<cmd>MetalsCompile<cr>", { buffer = bufnr, desc = "Metals compile" })
            vim.keymap.set("n", "<leader>mi", "<cmd>MetalsImportBuild<cr>", { buffer = bufnr, desc = "Metals import build" })
            vim.keymap.set("n", "<leader>md", function()
                require("metals").commands()
            end, { buffer = bufnr, desc = "Metals commands" })
            vim.keymap.set("n", "<leader>mr", "<cmd>LspRestart<cr>", { buffer = bufnr, desc = "Restart LSP server" })
            
            -- Scala 3 and Play Framework helpful commands
            vim.keymap.set("n", "<leader>mo", "<cmd>MetalsOrganizeImports<cr>", { buffer = bufnr, desc = "Organize imports" })
            vim.keymap.set("n", "<leader>mw", "<cmd>MetalsNewScalaFile<cr>", { buffer = bufnr, desc = "New Scala file" })
            
            -- Only set up inlay hints toggle if supported
            if client.server_capabilities.inlayHintProvider then
                vim.keymap.set("n", "<leader>mh", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(bufnr), { bufnr = bufnr })
                end, { buffer = bufnr, desc = "Toggle inlay hints" })
            end
            
            -- Alternative navigation when gd fails
            vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { buffer = bufnr, desc = "Find symbols in workspace" })
            vim.keymap.set("n", "<leader>fw", function()
                require('telescope.builtin').lsp_dynamic_workspace_symbols({
                    default_text = vim.fn.expand('<cword>')
                })
            end, { buffer = bufnr, desc = "Find workspace symbols (current word)" })
            vim.keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", { buffer = bufnr, desc = "Find definitions" })
            vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr, desc = "Find references" })
            vim.keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", { buffer = bufnr, desc = "Find implementations" })
            
            -- Enable inlay hints if supported
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
        end

        -- Autocmd that will actually be in charging of starting the whole thing
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "scala", "sbt", "java" },
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end
}
