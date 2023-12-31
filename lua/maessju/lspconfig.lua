local mason_installed = {
    "lua_ls",
    "ltex",
    "bashls",
    "clangd",
    "pyright",
    "rust_analyzer",
}

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = mason_installed,
})

local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
	    local opts = { noremap = true, silent = true, buffer = bufnr }

    local function buf_set_keymap(...)
        vim.keymap.set(...)
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", vim.lsp.buf.declaration, opts)
    buf_set_keymap("n", "gd", vim.lsp.buf.definition, opts)
    buf_set_keymap("n", "gt", vim.lsp.buf.type_definition, opts)
    buf_set_keymap("n", "K", vim.lsp.buf.hover, opts)
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- This is a weird fix for the visual selection not being used properly in the code_action() call
    buf_set_keymap("v", "<leader>ca", "<Esc>gv<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", vim.lsp.buf.references, opts)
    buf_set_keymap(
        "n",
        "<leader>D",
        vim.diagnostic.open_float,
        vim.tbl_extend("force", opts, { desc = "Hover diagnostics" })
    )
    buf_set_keymap("n", "[d", vim.diagnostic.goto_prev, opts)
    buf_set_keymap("n", "]d", vim.diagnostic.goto_next, opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    if client.server_capabilities.documentFormattingProvider or client.server_capabilities.document_formatting then
        F.set_autocmd("BufWritePre", function()
            vim.lsp.buf.format()
        end, { buffer = bufnr })
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- map buffer local keybindings when the language server attaches
local opts = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
}

-- Use a loop to conveniently call 'setup' on multiple servers and
for _, server in ipairs(mason_installed) do
    nvim_lsp[server].setup(opts)
end
