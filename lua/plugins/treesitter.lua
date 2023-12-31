-- Treesitter folds
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 89
vim.g.skip_ts_context_commentstring_module = true


require('nvim-treesitter.configs').setup({
  -- nvim-treesitter/nvim-treesitter (self config)
  auto_install = true,
  ensure_installed = {
    'c',
    'cpp',
    'css',
    'dockerfile',
    'fish',
    'gitignore',
    'html',
    'java',
    'javascript',
    'json',
    'latex',
    'lua',
    'make',
    'markdown',
    'tsx',
    'vim',
    'python',
    'typescript',
  },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = 'gs',
      -- NOTE: These are visual mode mappings
      node_incremental = 'gs',
      node_decremental = 'gS',
      scope_incremental = '<leader>gc',
    },
  },
  -- nvim-treesitter/nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = false,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['uc'] = '@comment.outer',

        -- Or you can define your own textobjects like this
        -- ["iF"] = {
        --     python = "(function_definition) @function",
        --     cpp = "(function_definition) @function",
        --     c = "(function_definition) @function",
        --     java = "(method_declaration) @function",
        -- },
      },
    },
    swap = {
      enable = false,
      --   swap_next = {
      --     ['<leader>a'] = '@parameter.inner',
      --     ['<leader>f'] = '@function.outer',
      --     ['<leader>e'] = '@element',
      --   },
      --   swap_previous = {
      --     ['<leader>A'] = '@parameter.inner',
      --     ['<leader>F'] = '@function.outer',
      --     ['<leader>E'] = '@element',
      --   },
    },
    move = {
      enable = false,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
  -- windwp/nvim-ts-autotag
  autotag = {
    enable = true,
  },
  -- nvim-treesitter/nvim-treesitter-refactor
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    -- highlight_current_scope = { enable = false },
  },
  matchup = {
    enable = true,
  },
})

require('ts_context_commentstring').setup{
  enable_autocmd = false;
}
