# headings.nvim

An extension for that allows you to switch between document's headings
using `vim.ui.select`.

By using the above API your can set your picker yourself without
any dependency on plugins like:

- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Snacks](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)
- [Mini.pick](https://github.com/nvim-mini/mini.pick)
- etc

## Supported File Types

| File Type        | Tree-sitter | Notes                                                          |
| ---------------- | ----------- | -------------------------------------------------------------- |
| AsciiDoc         | ✅          |                                                                |
| Beancount        | ✅          |                                                                |
| LaTeX            | ⬜          |                                                                |
| Markdown         | ✅          | including `vimwiki`, `vim-pandoc-syntax`, and `vim-gfm-syntax` |
| Neorg            | ✅          |                                                                |
| OrgMode          | ⬜          |                                                                |
| ReStructuredText | ✅          |                                                                |
| Vimdoc (help)    | ✅          |                                                                |

## Setup

Install with `lazy` package manager:

```lua
return {
  "xdavidel/headings.nvim",
  cmd = "Headings",
  keys = {
    {
      "<A-o>",
      function()
        require("headings").pick_headings()
      end,
      mode = { "n", "i" },
      desc = "Select Heading",
    },
  },
  opts = {},
}
```

The default configurations can be found in `headings.lua`.

### Tree-sitter Support

`headings.nvim` supports Tree-sitter for parsing documents and finding
headings. But not all file types are supported, you may check [Supported File
Types](#supported-file-types) section and inspect the Tree-sitter column.

If `nvim-treesitter` was not correctly loaded, it would have fallen back to
normal parsing. You may check `nvim-treesitter` configurations and whether your
language is `TSInstall`ed.

## Usage

```viml
:Headings
```

## Contributing

All contributions are welcome.

## Special Thanks

Thanks for David Zhang for his original work on:
[telescope-heading.nvim](https://github.com/crispgm/telescope-heading.nvim)

## License

Copyright 2025 David Delarosa. MIT License.
