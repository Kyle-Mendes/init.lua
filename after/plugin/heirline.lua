local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local palette = require("rose-pine.palette")

local function mode_color()
    local vim_mode = vim.fn.mode(1) -- :h mode()
    local mode = vim_mode:sub(1, 1) -- get only the first mode character
    local colors = {
        n = palette.love,
        i = palette.pine,
        v = palette.iris,
        V =  palette.iris,
        ["\22"] =  palette.iris,
        c =  palette.gold,
        s =  palette.foam,
        S =  palette.foam,
        ["\19"] =  palette.foam,
        R =  palette.rose,
        r =  palette.rose,
        ["!"] =  palette.love,
        t =  palette.love,
    }

    return colors[mode]
end

local ViMode = {
    -- get vim current mode, this information will be required by the provider
    -- and the highlight functions, so we compute it only once per component
    -- evaluation and store it as a component attribute
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()

        -- execute this only once, this is required if you want the ViMode
        -- component to be updated on operator pending mode
        if not self.once then
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "*:*o",
                command = 'redrawstatus'
            })
            self.once = true
        end
    end,
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
            n = "Normal",
            no = "N?",
            nov = "N?",
            noV = "N?",
            ["no\22"] = "N?",
            niI = "Ni",
            niR = "Nr",
            niV = "Nv",
            nt = "Nt",
            v = "Visual",
            vs = "Vs",
            V = "Visual Block",
            Vs = "Vs",
            ["\22"] = "Visual Column",
            ["\22s"] = "Visual Column",
            s = "S",
            S = "S_",
            ["\19"] = "^S",
            i = "Insert",
            ic = "Ic",
            ix = "Ix",
            R = "R",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "Command",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
        },
        mode_colors = {
            n = palette.love,
            i = palette.pine,
            v = palette.iris,
            V =  palette.iris,
            ["\22"] =  palette.iris,
            c =  palette.gold,
            s =  palette.foam,
            S =  palette.foam,
            ["\19"] =  palette.foam,
            R =  palette.rose,
            r =  palette.rose,
            ["!"] =  palette.love,
            t =  palette.love,
        }
    },
    -- We can now access the value of mode() that, by now, would have been
    -- computed by `init()` and use it to index our strings dictionary.
    -- note how `static` fields become just regular attributes once the
    -- component is instantiated.
    -- To be extra meticulous, we can also add some vim statusline syntax to
    -- control the padding and make sure our string is always at least 2
    -- characters long. Plus a nice Icon.
    provider = function(self)
        return "%2("..self.mode_names[self.mode].."%)"
    end,
    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
        return { fg = palette.base, bold = false, italic = true }
    end,
    -- Re-evaluate the component only on ModeChanged event!
    -- This is not required in any way, but it's there, and it's a small
    -- performance improvement.
    update = {
        "ModeChanged",
    },
}
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


local Vi = utils.surround({ "", "" }, function(self) return mode_color() end, {ViMode, hl = {fg = 'black'}} )

local StatusLine = { Vi, }
local WinBar = {}
local TabLine = { TabPages, }
local StatusColumn = {}

require("heirline").setup({
    statusline = StatusLine,
    winbar = WinBar,
    tabline = TabLine,
    -- statuscolumn = StatusColumn,
})
