local M = {}

local defaults = {
    treesitter = false,
    prompt = 'Select a heading:',
}

M.setup = function(opts)
    defaults = vim.tbl_deep_extend('force', defaults, opts or {})
end

M.pick_headings = function(opts)
    opts = vim.tbl_deep_extend('keep', defaults, opts or {})
    local headings = require('headings.utils').get_headings(opts)
    if headings == nil then
        return
    end
    vim.ui.select(headings, {
        prompt = opts.prompt,
        format_item = function(entry)
            return entry.heading
        end,
    }, function(entry)
        if entry ~= nil then
            vim.cmd(string.format('%d', entry.line))
        end
    end)
end

return M
