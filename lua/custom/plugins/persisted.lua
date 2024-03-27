local M = { interval = 60000, timer = nil }

function M.start()
  if M.timer == nil then
    M.timer = vim.loop.new_timer()
    M.timer:start(
      M.interval,
      M.interval,
      vim.schedule_wrap(function()
        require('persisted').save { session = vim.g.persisted_loaded_session }
      end)
    )
  end
end

function M.stop()
  if M.timer ~= nil then
    M.timer:close()
    M.timer = nil
  end
end

return {
  'olimorris/persisted.nvim',
  config = function()
    require('persisted').setup {
      autoload = true,
      allowed_dirs = {
        '/usr/home/heavyjoost/code',
        '/home/heavyjoost/code',
        '~/code',
        '~/.config/nvim',
      },
    }
    vim.keymap.set('n', '<leader>sp', ':Telescope persisted<cr>', { desc = '[S]earch [P]ersisted session' })
    pcall(require('telescope').load_extension, 'persisted')

    local group = vim.api.nvim_create_augroup('PersistedHooks', {})

    -- We want it to autosave every X seconds if the session is active
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedLoadPost,PersistedTelescopeLoadPost',
      group = group,
      callback = function(session)
        M.start()
      end,
    })
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedStateChange',
      group = group,
      callback = function(s)
        if s.data.action == 'start' then
          M.start()
        else
          M.stop()
        end
      end,
    })
  end,
}
