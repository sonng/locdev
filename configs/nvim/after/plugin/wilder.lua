local wilder = require("wilder")

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.python_file_finder_pipeline({
      -- to use ripgrep : {'rg', '--files'}
      -- to use fd      : {'fd', '-tf'}
      -- file_command = {'find', '.', '-type', 'f', '-printf', '%P\n'}, 
      file_command = {'rg', '--files' }, 
      -- to use fd      : {'fd', '-td'}
      -- dir_command = {'find', '.', '-type', 'd', '-printf', '%P\n'},
      dir_command = {'fd', '-td' },
      -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
      -- found at https://github.com/nixprime/cpsm
      filters = {'fuzzy_filter', 'difflib_sorter'},
    }),
    wilder.cmdline_pipeline(),
    wilder.python_search_pipeline()
  ),
})

wilder.set_option('renderer', wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
        highlighter = wilder.basic_highlighter(),
        left = {' ', wilder.popupmenu_devicons()},
        right = {' ', wilder.popupmenu_scrollbar()},
        highlights = {
            border = 'Normal',
        },
        border = 'single',
        empty_message = wilder.popupmenu_empty_message_with_spinner(),
    })
))

wilder.setup({ 
    modes = { ':', '/', '?' }
})
