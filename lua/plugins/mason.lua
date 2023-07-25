return{
    {

        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ui = { border = "rounded" },
            ensure_installed = {
                --"pylint",
                --"flake8",
                -- Formatter
                "stylua",
                "prettier",
                "shfmt",
                "jq",
                -- Linter
                "eslint_d",
                "standardrb",
                "golangci-lint",
                "shellcheck",
                "yamllint",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}