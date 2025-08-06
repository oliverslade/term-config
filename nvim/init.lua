---------------------------------------------------------------------
--  Neovim Configuration - Clean & Minimal                         --
---------------------------------------------------------------------

-- 1. Core modules -----------------------------------------------------------
require("options")
require("keymaps")
require("lazy-init")

-- 2. Helper: hot‑reload a Lua module ---------------------------------------
function R(name)
  require("plenary.reload").reload_module(name)
end

-- 3. Autocommand groups -----------------------------------------------------
local augroup  = vim.api.nvim_create_augroup
local autocmd  = vim.api.nvim_create_autocmd

local PrimeGroup   = augroup("ThePrimeagen",   {})
local YankHLGroup  = augroup("HighlightYank",  {})

-- 4. Custom file‑types ------------------------------------------------------
vim.filetype.add({ extension = { templ = "templ" } })

-- 5. Yank highlighting ------------------------------------------------------
autocmd("TextYankPost", {
  group    = YankHLGroup,
  pattern  = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
  end,
})

-- 6. Trim trailing whitespace on save --------------------------------------
autocmd("BufWritePre", {
  group   = PrimeGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- 7. LSP‑aware key‑maps -----------------------------------------------------
autocmd("LspAttach", {
  group    = PrimeGroup,
  callback = function(evt)
    local buf  = evt.buf
    local map  = vim.keymap.set
    local opts = { buffer = buf }
    local lsp  = vim.lsp.buf
    local diag = vim.diagnostic

    map("n", "gd",         lsp.definition,        opts)
    map("n", "K",          lsp.hover,             opts)
    map("n", "<leader>vws", lsp.workspace_symbol,  opts)
    map("n", "<leader>vd",  diag.open_float,       opts)
    map("n", "<leader>vca", lsp.code_action,       opts)
    map("n", "<leader>vrr", lsp.references,        opts)
    map("n", "<leader>vrn", lsp.rename,            opts)
    map("i", "<C-h>",       lsp.signature_help,     opts)
    map("n", "[d",          diag.goto_next,        opts)
    map("n", "]d",          diag.goto_prev,        opts)
  end,
})

-- 8. Diagnostic look‑and‑feel (inline errors) ------------------------------
-- single‑letter signs in the gutter
for type, icon in pairs { Error = "E", Warn = "W", Hint = "H", Info = "I" } do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- inline virtual text & general behaviour
vim.diagnostic.config({
  virtual_text   = { spacing = 4, prefix = "" }, -- message at end of line
  signs          = true,   -- keep the sign column enabled
  underline      = true,   -- subtle underline under the error segment
  update_in_insert = false,-- don't distract while typing
  severity_sort  = true,   -- highest severity first if multiple on a line
})

-- colour‑link virtual text to match sign colours (optional tweak)
vim.cmd [[
  highlight! link DiagnosticVirtualTextError DiagnosticError
  highlight! link DiagnosticVirtualTextWarn  DiagnosticWarn
  highlight! link DiagnosticVirtualTextInfo  DiagnosticInfo
  highlight! link DiagnosticVirtualTextHint  DiagnosticHint
]]

