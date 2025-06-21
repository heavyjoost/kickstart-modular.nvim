return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      -- require('mini.ai').setup { n_lines = 500 }
      -- Stolen from LazyVim :)
      function ai_whichkey(opts)
        local objects = {
          { ' ', desc = 'whitespace' },
          { '"', desc = '" string' },
          { "'", desc = "' string" },
          { '(', desc = '() block' },
          { ')', desc = '() block with ws' },
          { '<', desc = '<> block' },
          { '>', desc = '<> block with ws' },
          { '?', desc = 'user prompt' },
          { 'U', desc = 'use/call w/o dot' },
          { '[', desc = '[] block' },
          { ']', desc = '[] block with ws' },
          { '_', desc = 'underscore' },
          { '`', desc = '` string' },
          { 'a', desc = 'argument' },
          { 'b', desc = ')]} block' },
          { 'c', desc = 'class' },
          { 'd', desc = 'digit(s)' },
          { 'e', desc = 'CamelCase / snake_case' },
          { 'f', desc = 'function' },
          -- { "g", desc = "entire file" },
          -- { "i", desc = "indent" },
          { 'o', desc = 'block, conditional, loop' },
          { 'q', desc = 'quote `"\'' },
          { 't', desc = 'tag' },
          { 'u', desc = 'use/call' },
          { '{', desc = '{} block' },
          { '}', desc = '{} with ws' },
        }

        local ret = { mode = { 'o', 'x' } }
        ---@type table<string, string>
        local mappings = vim.tbl_extend('force', {}, {
          around = 'a',
          inside = 'i',
          around_next = 'an',
          inside_next = 'in',
          around_last = 'al',
          inside_last = 'il',
        }, opts.mappings or {})
        mappings.goto_left = nil
        mappings.goto_right = nil

        for name, prefix in pairs(mappings) do
          name = name:gsub('^around_', ''):gsub('^inside_', '')
          ret[#ret + 1] = { prefix, group = name }
          for _, obj in ipairs(objects) do
            local desc = obj.desc
            if prefix:sub(1, 1) == 'i' then
              desc = desc:gsub(' with ws', '')
            end
            ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
          end
        end
        require('which-key').add(ret, { notify = false })
      end

      local ai = require 'mini.ai'
      local ai_opts = {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter { -- code block
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          },
          f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
          c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
          d = { '%f[%d]%d+' }, -- digits
          e = { -- Word with case
            { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
            '^().*()$',
          },
          -- i = LazyVim.mini.ai_indent, -- indent
          -- g = LazyVim.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function name
        },
      }
      ai.setup(ai_opts)
      ai_whichkey(ai_opts)

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
