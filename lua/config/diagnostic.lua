local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({name = 'DiagnosticSignError',text = '✘ '})
sign({name = 'DiagnosticSignWarn', text = '▲ '})
sign({name = 'DiagnosticSignHint', text = '⚑ '})
sign({name = 'DiagnosticSignInfo', text = ' '})

vim.diagnostic.config({
    virtual_text = {
        severity = vim.diagnostic.severity.ERROR, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    },
    update_in_insert = false,
    signs = true,
    severity_sort = true,
    float = {
        source = "always",  -- Or "if_many"
    },
})

vim.diagnostic.open_float = (function(orig)
    return function(bufnr, opts)
        local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
        local opts = opts or {}
        -- A more robust solution would check the "scope" value in `opts` to
        -- determine where to get diagnostics from, but if you're only using
        -- this for your own purposes you can make it as simple as you like
        local diagnostics = vim.diagnostic.get(opts.bufnr or 0, {lnum = lnum})
        local max_severity = vim.diagnostic.severity.HINT
        for _, d in ipairs(diagnostics) do
            -- Equality is "less than" based on how the severities are encoded
            if d.severity < max_severity then
                max_severity = d.severity
            end
        end
        local border_color = ({
            [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
            [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
            [vim.diagnostic.severity.WARN]  = "DiagnosticWarn",
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
        })[max_severity]
        opts.border = {
            { "╔" , border_color },
            { "═" , border_color },
            { "╗" , border_color },
            { "║" , border_color },
            { "╝" , border_color },
            { "═" , border_color },
            { "╚" , border_color },
            { "║" , border_color },
        }
        orig(bufnr, opts)
    end
end)(vim.diagnostic.open_float)

-- Show line diagnostics in floating popup on hover, except insert mode (CursorHoldI)
--vim.o.updatetime = 250
--vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float()]]
