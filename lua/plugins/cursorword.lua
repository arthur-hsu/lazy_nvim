return {
    {
        "RRethy/vim-illuminate",
        -- event = "VeryLazy",
        event = { "BufReadPost", "BufNewFile" },

        config = function()
            -- default configuration
            require('illuminate').configure({
                -- providers: provider used to get references in the buffer, ordered by priority
                providers = {
                    'lsp',
                    'treesitter',
                    'regex',
                },
                -- delay: delay in milliseconds
                delay = 50,
                -- filetype_overrides: filetype specific overrides.
                -- The keys are strings to represent the filetype while the values are tables that
                -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
                filetype_overrides = {},
                -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
                filetypes_denylist = {
                    'dirbuf',
                    'dirvish',
                    'fugitive',
                    'TelescopePrompt',
                    'alpha',
                    'mason',
                    'lazy',
                    'DiffviewFileHistory',
                    'DiffviewFiles',
                    'Trouble',
                    'lspinfo'
                },
                -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
                -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
                filetypes_allowlist = {},
                -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
                -- See `:help mode()` for possible values
                modes_denylist = {},
                -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
                -- See `:help mode()` for possible values
                modes_allowlist = {},
                -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
                -- Only applies to the 'regex' provider
                -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
                providers_regex_syntax_denylist = {},
                -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
                -- Only applies to the 'regex' provider
                -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
                providers_regex_syntax_allowlist = {},
                -- under_cursor: whether or not to illuminate under the cursor
                under_cursor = true,
                -- large_file_cutoff: number of lines at which to use large_file_config
                -- The `under_cursor` option is disabled when this cutoff is hit
                large_file_cutoff = nil,
                -- large_file_config: config to use for large files (based on large_file_cutoff).
                -- Supports the same keys passed to .configure
                -- If nil, vim-illuminate will be disabled for large files.
                large_file_overrides = nil,
                -- min_count_to_highlight: minimum number of matches required to perform highlighting
                min_count_to_highlight = 2,
                -- should_enable: a callback that overrides all other settings to
                -- enable/disable illumination. This will be called a lot so don't do
                -- anything expensive in it.
                should_enable = function(bufnr) return true end,
                -- case_insensitive_regex: sets regex case sensitivity
                case_insensitive_regex = false,
            })
            local highlighting = {
                cterm = { bold = true },
                bold = true,
                italic = false,
                underline = true
            }
            vim.api.nvim_set_hl(0, "IlluminatedWordText", highlighting)
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", highlighting)
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", highlighting)
            vim.cmd[[IlluminateToggle]]
        end
    },
    {
        -- NOTE: highlight CursorWord
        "sontungexpt/stcursorword",
        enabled = true,
        event = "VeryLazy",
        config = function()
            -- default configuration
            require("stcursorword").setup({
                max_word_length = 100, -- if cursorword length > max_word_length then not highlight
                min_word_length = 2,   -- if cursorword length < min_word_length then not highlight
                excluded = {
                    filetypes = {
                        "TelescopePrompt",
                        "alpha",
                        "mason",
                        "lazy",
                        "DiffviewFileHistory",
                        "DiffviewFiles",
                        "Trouble",
                        "lspinfo"
                    },
                    buftypes = {
                        "nofile",
                        "help",
                        "terminal",
                    },
                    patterns = { -- the pattern to match with the file path
                        -- "%.png$",
                        -- "%.jpg$",
                        -- "%.jpeg$",
                        -- "%.pdf$",
                        -- "%.zip$",
                        -- "%.tar$",
                        -- "%.tar%.gz$",
                        -- "%.tar%.xz$",
                        -- "%.tar%.bz2$",
                        -- "%.rar$",
                        -- "%.7z$",
                        -- "%.mp3$",
                        -- "%.mp4$",
                    },
                },
                highlight = {
                    underline = false,
                    -- reverse = true,
                    bg = nil,
                    fg = nil,
                    bold = true,
                    -- bg = '#191919',
                    -- fg = '#b3b8f5',
                },
            })
            vim.cmd('Cursorword disable')
        end
    }
}
