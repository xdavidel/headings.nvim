M = {}

local plugin_info_header = 'Headings'

M.filetype = function()
    local ft_maps = {
        ['vimwiki'] = 'markdown',
        ['pandoc'] = 'markdown',
        ['markdown.pandoc'] = 'markdown',
        ['markdown.gfm'] = 'markdown',
        ['tex'] = 'latex',
        ['help'] = 'vimdoc',
        ['asciidoctor'] = 'asciidoc',
    }
    local ft = vim.bo.filetype
    if ft_maps[ft] ~= nil then
        ft = ft_maps[ft]
    end

    return ft
end

M.support_treesitter = function(ft)
    local ts_ft_maps = {
        ['beancount'] = true,
        ['markdown'] = true,
        ['rst'] = true,
        ['vimdoc'] = true,
        ['norg'] = true,
    }

    if ts_ft_maps[ft] ~= nil then
        return ts_ft_maps[ft]
    end
    return false
end

M.get_headings = function(opts)
    local ft = M.filetype()
    local mod_path = string.format('headings.format.%s', ft)
    local ok, mod = pcall(require, mod_path)
    if not ok then
        vim.notify(
            'The file type is not supported',
            vim.log.levels.WARN,
            { title = plugin_info_header }
        )
        return nil
    end

    local index, total = 1, vim.fn.line('$')
    local bufnr = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    if opts.treesitter and M.support_treesitter(ft) then
        if vim._ts_has_language(ft) then
            return mod.ts_get_headings(filepath, bufnr)
        else
            vim.notify(
                string.format(
                    'No treesitter language parser installed for [%s]. Fallback to normal parser.',
                    ft
                ),
                vim.log.levels.WARN,
                { title = plugin_info_header }
            )
        end
    end

    return mod.get_headings(filepath, index, total)
end

return M
