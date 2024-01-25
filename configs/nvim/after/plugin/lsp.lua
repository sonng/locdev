local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.skip_server_setup({'rust_analyzer'})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    -- Goto Definition
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

    -- Hover 
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

    -- search by Type
    vim.keymap.set("n", "<leader>t", function() vim.lsp.buf.workspace_symbol() end, opts)

    -- close quickfix
    vim.keymap.set("n", "<leader>cqf", ":ccl<CR>", opts)

    -- Next Diagnostics
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    -- Previous Diagnostics
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    -- Variable Diagnostics
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)

    -- Variable Code Action
    vim.keymap.set("n", "<leader>.", function() vim.lsp.buf.code_action() end, opts)
    -- varible References
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    -- variable ReName
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    -- Variable Incoming Calls
    vim.keymap.set("n", "<leader>ic", function() vim.lsp.buf.incoming_calls() end, opts)
    -- Variable Outgoing Calls
    vim.keymap.set("n", "<leader>oc", function() vim.lsp.buf.outgoing_calls() end, opts)
    -- Next & Back quickfix
    vim.keymap.set("n", "<leader>]", ":cnext<CR>", opts)
    vim.keymap.set("n", "<leader>[", ":cprev<CR>", opts)

    -- Control-Help
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    -- Format code
    vim.keymap.set("n", "<leader>fc", function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end, opts)
end)

lsp.setup()

local rust_tools = require('rust-tools')

rust_tools.setup({
    server = {
        on_attach = function(_, bufnr)
            local opts = {buffer = bufnr}

            -- Rust Code Action
            vim.keymap.set("n", "<leader>rca", rust_tools.hover_actions.hover_action, opts)
        end
    }
})

vim.diagnostic.config({
    virtual_text = true
})
