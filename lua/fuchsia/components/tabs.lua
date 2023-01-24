
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local palette = require("rose-pine.palette")

local TabMod = { -- Add an unsaved indicator
    provider = function(self)
        local window = vim.api.nvim_tabpage_get_win(self.tabnr)
        local buffer = vim.api.nvim_win_get_buf(window)
        local modified = vim.api.nvim_buf_get_option(buffer, "modified")
        if modified then
            return "•"
        end
    end,
    hl = function(self)
        return {fg = "#32CD32"}
    end,
}

local Tabpage = {
    provider = function(self)
        local window = vim.api.nvim_tabpage_get_win(self.tabnr)
        local buffer = vim.api.nvim_win_get_buf(window)
        local filename = vim.api.nvim_buf_get_name(buffer)

        return filename
    end,
    hl = function(self)
        if not self.is_active then
            return "TabLine"
        else
            return "TabLineSel"
        end
    end,
}

local TabpageClose = {
    provider = "%999X  %X",
    hl = "TabLine",
}

local TabPages = {
    -- only show this component if there's 2 or more tabpages
    condition = function()
        return #vim.api.nvim_list_tabpages() >= 2
    end,
    { provider = "%=" },
    utils.make_tablist(utils.surround({"",""}, function(self)
        if self.is_active then
            return utils.get_highlight("TabLineSel").bg
        else
            return utils.get_highlight("TabLine").bg
        end
    end,{ TabMod, Tabpage })),
    TabpageClose,
}

return {TabPages}
