local spec = {
    "nvim-tree/nvim-tree.lua",
    name = "nvim-tree",
    lazy = false,
    keys = {
        "<leader>e",
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}

function spec:config()
    local nvimtree = require("nvim-tree")

    nvimtree.setup({
        filters = {
            dotfiles = false,
            custom = { "^\\.git$" },
        },
        disable_netrw = true,
        hijack_netrw = true,
        prefer_startup_root = true,
        hijack_cursor = false,
        hijack_unnamed_buffer_when_opening = false,
        sync_root_with_cwd = false,
        hijack_directories = {
            enable = true,
            auto_open = true,
        },
        update_focused_file = {
            enable = true,
            update_cwd = false,
        },
        view = {
            adaptive_size = false,
            side = "right",
            width = 30,
            hide_root_folder = false,
        },
        git = {
            enable = true,
            ignore = false,
        },
        filesystem_watchers = {
            enable = true,
        },
        renderer = {
            highlight_git = true,
            highlight_opened_files = "none",

            indent_markers = {
                enable = true,
            },

            icons = {
                webdev_colors = true,
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        default = "",
                        empty = "",
                        empty_open = "",
                        open = "",
                        symlink = "",
                        symlink_open = "",
                        arrow_open = "",
                        arrow_closed = "",
                    },
                    git = {
                        staged = "✓",
                        deleted = "",
                        renamed = "➜",
                        unstaged = "",
                        -- unstaged = "✗",
                        unmerged = "",
                        -- unmerged = "",
                        untracked = "",
                        -- untracked = "★",
                        ignored = "",
                        -- ignored = "◌",
                    },
                },
            },
        },
    })

    vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
            local api = require("nvim-tree.api")

            -- Do not put the tree in full screen when closing a buffer
            if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
                vim.defer_fn(function()
                    api.tree.toggle({ find_file = true, focus = true })
                    api.tree.toggle({ find_file = true, focus = true })
                    vim.cmd("wincmd p")
                end, 0)
            end

            -- Open new file upon creation
            -- require("nvim-tree.api").events.subscribe(
            --     api.events.Event.FileCreated,
            --     function(file)
            --         vim.cmd("edit " .. file.fname)
            --     end
            -- )
        end,
    })

    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {})
end

return spec
