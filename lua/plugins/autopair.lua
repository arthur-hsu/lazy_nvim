return{
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    },
    {
        'altermo/ultimate-autopair.nvim',
        -- event={'InsertEnter','CmdlineEnter'},
        event="VeryLazy",
        branch='development',
        -- branch='v0.6',
        -- enabled=false,
        config = function ()
            require('ultimate-autopair').setup({
                -- pair_cmap=false,
                multiline=true,
                tabout = {
                    enable = true,
                    hopout = true,
                },
                space2={
                    enable=true,
                },
                close = {  -- *ultimate-autopair-map-close-config*
                    enable = true,
                    map = '<A-]>', --string or table
                    cmap = '<A-]>', --string or table
                },

                {'``','``',fly=true,suround=true,dosuround=true,newline=true,space=false, ft={'python'}},
                -- {'*','*',suround=true,dosuround=true,newline=true,space=false, ft={'markdown'}},
                -- {'**','**',suround=true,dosuround=true,newline=true,space=false, ft={'markdown'}},
                -- {'***','***',suround=true,dosuround=true,newline=true,space=false, ft={'markdown'}},
                internal_pairs={-- *ultimate-autopair-pairs-default-pairs*
                    {'[',']',fly=true,dosuround=true,newline=true,space=true},
                    {'(',')',fly=true,dosuround=true,newline=true,space=true},
                    {'{','}',fly=true,dosuround=true,newline=true,space=true},
                    {'"','"',suround=true,multiline=false},
                    {"'","'",suround=true,cond=function(fn) return not fn.in_lisp() or fn.in_string() end,alpha=true,nft={'tex'},multiline=false},
                    {'`','`',cond=function(fn) return not fn.in_lisp() or fn.in_string() end,nft={'tex'},multiline=false},
                    {'``',"''",ft={'tex'}},
                    {'```','```',newline=true,ft={'markdown'}},
                    {'<!--','-->',ft={'markdown','html'},space=true},
                    {'"""','"""',newline=true,ft={'python'}},
                    {"'''","'''",newline=true,ft={'python'}},
                },
                config_internal_pairs={
                     --{'{','}',suround=true},
                    {'"','"',newline=true,multiline=true},
                    {"'","'",newline=true,multiline=true},
                    {'```','```',newline=true,multiline=true},
                },


            })

            local function ls_name_from_event(event) return event.entry.source.source.client.config.name end
            local cmp=require('cmp')
            local Kind=cmp.lsp.CompletionItemKind
            -- Add parenthesis on completion confirmation
            cmp.event:on(
                'confirm_done',
                function(event)
                    local ok, ls_name = pcall(ls_name_from_event, event)
                    if ok and (ls_name == 'rust-analyzer' or ls_name == 'lua_ls') then
                        return
                    end

                    local completion_kind = event.entry:get_completion_item().kind
                    if vim.tbl_contains({ Kind.Function, Kind.Method }, completion_kind) then
                        local left = vim.api.nvim_replace_termcodes('<Left>', true, true, true)
                        vim.api.nvim_feedkeys('()' .. left, 'n', false)
                    end
                end
            )
        end
    },
}
