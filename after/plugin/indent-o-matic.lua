require('indent-o-matic').setup {
    -- The values indicated here are the defaults

    -- Number of lines without indentation before giving up (use -1 for infinite)
    max_lines = 2048,

    -- Space indentations that should be detected
    standard_widths = { 2, 4, 8 },

    -- Skip multi-line comments and strings (more accurate detection but less performant)
    skip_multiline = true,

     -- Don't detect 8 spaces indentations inside files without a filetype
    filetype_ = {
        standard_widths = { 2, 4 },
    },

     -- Only detect 4 spaces and tabs for Rust files
    filetype_rust = {
        standard_widths = { 4 },
    },

    filetype_typescript = {
        standard_widths = { 2, 4 },
    },
    filetype_javascript = {
        standard_widths = { 2, 4 },
    },
}

