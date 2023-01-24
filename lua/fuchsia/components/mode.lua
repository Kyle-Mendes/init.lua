local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local palette = require("rose-pine.palette")

local M = {}

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
local Mode = utils.surround({ "", "" }, function(self) return mode_color() end, {ViMode, hl = {fg = 'black'}} )

M.mode_color = mode_color
M.Mode = Mode
return M
