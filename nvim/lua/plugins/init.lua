-- Basic Plugins Configuration

return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    "eandrju/cellular-automaton.nvim",
    "gpanders/editorconfig.nvim",
    
    -- File Explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 30,
                    side = "left",
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
                git = {
                    enable = true,
                },
                actions = {
                    open_file = {
                        quit_on_open = false,
                    },
                },
            })
        end,
    },
}
