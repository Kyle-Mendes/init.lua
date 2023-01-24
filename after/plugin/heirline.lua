local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local palette = require("rose-pine.palette")

local CurrentFile = require("fuchsia.components.currentFile")
local Mode = require("fuchsia.components.mode")
local TabPages = require("fuchsia.components.tabs")

local lsp_status = require('lsp-status')
lsp_status.register_progress()

local LSPActive = {
    condition = conditions.lsp_attached,
    update = {'LspAttach', 'LspDetach'},

    -- You can keep it simple,
    -- provider = " [LSP]",

    -- Or complicate things a bit and get the servers names
    provider = function()
        local names = {}
        for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        return " [" .. table.concat(names, " ") .. "]"
    end,
    hl = { fg = palette.foam, bold = true },
}

local LSPMessages = {
    provider = function()
        return require("lsp-status").status()
    end,
    hl = { fg = "gray" },
}

local Align = { provider = "%=" }
local Space = { provider = " " }

local StatusLine = { Mode.Mode, CurrentFile, Align, LSPActive, LSPMessages, }
local WinBar = {}
local TabLine = { TabPages, }
local StatusColumn = {}

require("heirline").setup({
    statusline = StatusLine,
    winbar = WinBar,
    tabline = TabLine,
    -- statuscolumn = StatusColumn,
})


-- Util
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

