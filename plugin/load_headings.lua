vim.api.nvim_create_user_command('Headings', function()
    require('headings').pick_headings()
end, {})
