local M = {
    "folke/noice.nvim",
    --enabled = false,
    dependencies = {'nvim-tree/nvim-web-devicons',"MunifTanjim/nui.nvim","rcarriga/nvim-notify",},
    event="VeryLazy",
    --event = { "BufReadPost", "BufNewFile" },
}

function M.config()
    require("noice").setup(
    {
        ---"@type NoicePresets"
        presets = {
            -- you can enable a preset by setting it to true, or a table that will override the preset config
            -- you can also add custom presets that you can enable/disable with enabled=true
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = false, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        cmdline = {
            --🔍⌄
            enabled = true, -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            format = {
                search_down = { kind = "search", pattern = "^/", icon = "🔍 ", lang = "regex" },
                search_up = { kind = "search", pattern = "^%?", icon = "🔍 ", lang = "regex" },
            },
            opts = {}, -- global options for the cmdline. See section on views
            ---"@type table<string, CmdlineFormat>"
        },
        messages = {
            --------------------------------------------------------------------------------
            --View             Backend    Description
            ---------------- ---------- ----------------------------------------------------
            --notify           notify     nvim-notify with level=nil, replace=false, merge=false
            --split            split      horizontal split
            --vsplit           split      vertical split
            --popup            popup      simple popup
            --mini             mini       minimal view, by default bottom right, right-aligned
            --cmdline          popup      bottom line, similar to the classic cmdline
            --cmdline_popup    popup      fancy cmdline popup, with different styles according to the cmdline mode
            --cmdline_output   split      split used by config.presets.cmdline_output_to_split
            --messages         split      split used for :messages
            --confirm          popup      popup used for confirm events
            --hover            popup      popup used for lsp signature help and hover
            --popupmenu        nui.menu   special view with the options used to render the popupmenu when backend is nui
            --------------------------------------------------------------------------------
            -- NOTE: If you enable messages, then the cmdline is enabled automatically.
            -- This is a current Neovim limitation.
            enabled = true, -- enables the Noice messages UI
            view = "mini", -- default view for messages
            view_error = "mini", -- view for errors
            view_warn = "mini", -- view for warnings
            view_history = "messages", -- view for :messages
            view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
        popupmenu = {
            enabled = true, -- enables the Noice popupmenu UI
            ---@type 'nui'|'cmp'
            backend = "cmp", -- backend to use to show regular cmdline completions
            ---@type "NoicePopupmenuItemKind|false"
            -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
            kind_icons = true, -- set to `false` to disable icons
        },
        -- default options for require('noice').redirect
        -- see the section on Command Redirection
        ---@type "NoiceRouteConfig"
        redirect = {
            view = "popup",
            filter = { event = "msg_show" },
        },
        -- You can add any custom commands below that will be available with `:Noice command`
        ---"@type table<string, NoiceCommand>"
        commands = {
            history = {
                -- options for the message history that you get with `:Noice`
                view = "split",
                opts = { enter = true, format = "details" },
                filter = {
                    any = {
                        { event = "notify" },
                        { error = true },
                        { warning = true },
                        { event = "msg_show", kind = { "" } },
                        { event = "lsp", kind = "message" },
                    },
                },
            },
            -- :Noice last
            last = {
                view = "popup",
                opts = { enter = true, format = "details" },
                filter = {
                    any = {
                        { event = "notify" },
                        { error = true },
                        { warning = true },
                        { event = "msg_show", kind = { "" } },
                        { event = "lsp", kind = "message" },
                    },
                },
                filter_opts = { count = 1 },
            },
            -- :Noice errors
            errors = {
                -- options for the message history that you get with `:Noice`
                view = "popup",
                opts = { enter = true, format = "details" },
                filter = { error = true },
                filter_opts = { reverse = true },
            },
        },
        notify = {
            -- Noice can be used as `vim.notify` so you can route any notification like other messages
            -- Notification messages have their level and other properties set.
            -- event is always "notify" and kind can be any log level as a string
            -- The default routes will forward notifications to nvim-notify
            -- Benefit of using Noice for this is the routing and consistent history view
            enabled = false,
            view = "notify",
        },
        lsp = {
            progress = {
                enabled = true,
                -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
                -- See the section on formatting for more details on how to customize.
                --- "@type NoiceFormat|string"
                format = "lsp_progress",
                --- "@type NoiceFormat|string"
                format_done = "lsp_progress_done",
                throttle = 1000 / 30, -- frequency to update lsp progress message
                view = "mini",
            },
            override = {
                -- override the default lsp markdown formatter with Noice
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                -- override the lsp markdown formatter with Noice
                ["vim.lsp.util.stylize_markdown"] = true,
                -- override cmp documentation with Noice (needs the other options to work)
                ["cmp.entry.get_documentation"] = true,
            },
            hover = {
                enabled = true,
                silent = true, -- set to true to not show a message if hover is not available
                view = nil, -- when nil, use defaults from documentation
                ---"@type NoiceViewOptions"
                opts = {}, -- merged with defaults from documentation
            },
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                    trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                    luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                    throttle = 10, -- Debounce lsp signature help request by 50ms
                },
                view = nil, -- when nil, use defaults from documentation
                ---"@type NoiceViewOptions"
                opts = {}, -- merged with defaults from documentation
            },
            message = {
                -- Messages shown by lsp servers
                enabled = true,
                view = "mini",
                opts = {},
            },
            -- defaults for hover and signature help
            documentation = {
                view = "hover",
                ---"@type NoiceViewOptions"
                opts = {
                    lang = "markdown",
                    replace = true,
                    render = "plain",
                    format = { "{message}" },
                    win_options = { concealcursor = "n", conceallevel = 3 },
                },
            },
        },
        throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
        ---"@type NoiceConfigViews"
        views = {}, ---@see section on views
        ---"@type NoiceRouteConfig[]"
        routes = {}, --- @see section on routes
        ---"@type table<string, NoiceFilter>"
        status = {}, --- @see section on statusline components
        ---"@type NoiceFormatOptions"
    })
    vim.keymap.set({"n", "i", "s"}, "<c-f>", function()
        if not require("noice.lsp").scroll(4) then
            return "<c-f>"
        end
    end, { silent = true, expr = true })

    vim.keymap.set({"n", "i", "s"}, "<c-b>", function()
        if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
        end
    end, { silent = true, expr = true })
end
return M
