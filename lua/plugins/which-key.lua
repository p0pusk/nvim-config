local M = {}
local icons = require('icons')

M.config = {
  ---@usage disable which-key completely [not recommended]
  setup = {
    plugins = {
      marks = false, -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = false, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
      spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
      breadcrumb = icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
      separator = icons.ui.BoldArrowRight, -- symbol used between a key and it's label
      group = icons.ui.Plus, -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = 'single', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
      margin = { 0, 70, 0, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    show_help = false, -- show help message on the command line when the popup is visible
    triggers = 'auto', -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      n = { ':' },
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
  },

  opts = {
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  vopts = {
    mode = 'v', -- VISUAL mode
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  vmappings = {
    ['/'] = {
      '<Plug>(comment_toggle_linewise_visual)',
      'Comment toggle linewise (visual)',
    },
  },
  mappings = {
    [';'] = { '<cmd>Dashboard<CR>', 'Dashboard' },
    f = {
      function()
        local ok = pcall(
          require('telescope.builtin').git_files,
          { show_untracked = false }
        )
        if not ok then
          require('telescope.builtin').find_files()
        end
      end,
      'Telescope files',
    },
    H = { require('telescope.builtin').help_tags, 'Help' },
    [','] = { require('telescope.builtin').buffers, 'Buffers' },
    ['/'] = {
      '<Plug>(comment_toggle_linewise_current)',
      'Comment toggle current line',
    },
    h = { '<cmd>nohlsearch<CR>', 'No Highlight' },
    ["'"] = {
      name = 'search more',
      r = { require('telescope.builtin').live_grep, 'Grep' },
      c = { require('telescope.builtin').git_status, 'Changed git files' },
    },
    b = {
      name = 'Buffers',
      j = { '<cmd>BufferLinePick<cr>', 'Jump' },
      f = { '<cmd>Telescope buffers<cr>', 'Find' },
      b = { '<cmd>BufferLineCyclePrev<cr>', 'Previous' },
      n = { '<cmd>BufferLineCycleNext<cr>', 'Next' },
      W = { '<cmd>noautocmd w<cr>', 'Save without formatting (noautocmd)' },
      -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
      e = {
        '<cmd>BufferLinePickClose<cr>',
        'Pick which buffer to close',
      },
      h = { '<cmd>BufferLineCloseLeft<cr>', 'Close all to the left' },
      l = {
        '<cmd>BufferLineCloseRight<cr>',
        'Close all to the right',
      },
      D = {
        '<cmd>BufferLineSortByDirectory<cr>',
      },
      L = {
        '<cmd>BufferLineSortByExtension<cr>',
        'Sort by language',
      },
    },
    d = {
      name = 'Debug',
      t = {
        require('dap').toggle_breakpoint,
        'Toggle Breakpoint',
      },
      b = { require('dap').step_back, 'Step Back' },
      c = { require('dap').continue, 'Continue' },
      C = { require('dap').run_to_cursor, 'Run To Cursor' },
      d = { require('dap').disconnect, 'Disconnect' },
      g = { require('dap').session, 'Get Session' },
      i = { require('dap').step_into, 'Step Into' },
      o = { require('dap').step_over, 'Step Over' },
      u = { require('dap').step_out, 'Step Out' },
      p = { require('dap').pause, 'Pause' },
      r = { require('dap').repl.toggle, 'Toggle Repl' },
      s = { require('dap').continue, 'Start' },
      q = { require('dap').close, 'Quit' },
      U = { require('dapui').toggle, 'Toggle UI' },
    },

    -- " Available Debug Adapters:
    -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
    -- " Adapter configuration and installation instructions:
    -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    -- " Debug Adapter protocol:
    -- "   https://microsoft.github.io/debug-adapter-protocol/
    -- " Debugging
    g = {
      name = 'Git',
      g = {
        '<cmd>G<cr>',
        'Fugitive',
      },
      j = {
        "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
        'Next Hunk',
      },
      k = {
        "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
        'Prev Hunk',
      },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", 'Blame' },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", 'Preview Hunk' },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", 'Reset Hunk' },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", 'Reset Buffer' },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", 'Stage Hunk' },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        'Undo Stage Hunk',
      },
      o = { '<cmd>Telescope git_status<cr>', 'Open changed file' },
      b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
      c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
      C = {
        '<cmd>Telescope git_bcommits<cr>',
        'Checkout commit(for current file)',
      },
      d = {
        '<cmd>Gitsigns diffthis HEAD<cr>',
        'Git Diff',
      },
    },
    l = {
      name = 'LSP',
      a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
      d = {
        '<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>',
        'Buffer Diagnostics',
      },
      w = { '<cmd>Telescope diagnostics<cr>', 'Diagnostics' },
      u = { '<cmd>LspRestart<cr>', 'Restart LSP' },
      i = { '<cmd>LspInfo<cr>', 'Info' },
      I = { '<cmd>Mason<cr>', 'Mason Info' },
      j = {
        vim.diagnostic.goto_next,
        'Next Diagnostic',
      },
      k = {
        vim.diagnostic.goto_prev,
        'Prev Diagnostic',
      },
      l = { vim.lsp.codelens.run, 'CodeLens Action' },
      q = { vim.diagnostic.setloclist, 'Quickfix' },
      r = { vim.lsp.buf.rename, 'Rename' },
      s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
      S = {
        '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
        'Workspace Symbols',
      },
      e = { '<cmd>Telescope quickfix<cr>', 'Telescope Quickfix' },
    },
    c = {
      name = '+Code',
      e = {
        "<cmd>lua require('swenv.api').pick_venv()<cr>",
        'Pick virtual-env',
      },
    },
    n = {
      name = '+Config',
      s = {
        name = '+Snippets',
        u = {
          '<cmd>source ~/.config/nvim/lua/lsp/luasnip.lua<cr>',
          'Update snippets',
        },
        s = {
          '<cmd>e ~/.config/nvim/snippets/all.lua<cr>',
          'Edit snippets',
        },
      },

      c = {
        '<cmd>edit ~/.config/nvim/init.lua<cr>',
        'Edit init.lua',
      },

      k = { '<cmd>Telescope keymaps<cr>', 'View keymappings' },

      l = {
        name = '+logs',
        L = {
          "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>",
          'Open the LSP logfile',
        },

        N = { '<cmd>edit $NVIM_LOG_FILE<cr>', 'Open the Neovim logfile' },
      },

      u = { '<cmd>Restart<cr>', 'Update config' },
    },
    s = {
      name = 'Search',
      b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
      c = { '<cmd>Telescope colorscheme<cr>', 'Colorscheme' },
      f = { '<cmd>Telescope find_files<cr>', 'Find File' },
      h = { '<cmd>Telescope help_tags<cr>', 'Find Help' },
      H = { '<cmd>Telescope highlights<cr>', 'Find highlight groups' },
      M = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
      r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
      R = { '<cmd>Telescope registers<cr>', 'Registers' },
      t = { '<cmd>Telescope live_grep<cr>', 'Text' },
      k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
      C = { '<cmd>Telescope commands<cr>', 'Commands' },
      p = {
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        'Colorscheme with Preview',
      },
    },
    T = {
      name = 'Treesitter',
      i = { ':TSConfigInfo<cr>', 'Info' },
    },
  },
}

M.setup = function()
  local which_key = require('which-key')

  which_key.setup(M.config.setup)

  local opts = M.config.opts
  local vopts = M.config.vopts

  local mappings = M.config.mappings
  local vmappings = M.config.vmappings

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end

return M
