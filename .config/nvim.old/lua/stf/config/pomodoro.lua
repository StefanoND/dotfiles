local pomodoro = require("pomo")

local opts = { silent = true, remap = false }

-- Pomodoro Hide/Show
vim.keymap.set("n", "<leader>ph", "<cmd>TimerHide<CR>", opts)
vim.keymap.set("n", "<leader>ps", "<cmd>TimerShow<CR>", opts)

-- Pomodoro 25/5 minutes work/break
vim.keymap.set("n", "<leader>pow", "<cmd>TimerStart 25m work<CR>", opts)
vim.keymap.set("n", "<leader>pob", "<cmd>TimerStart 5m break<CR>", opts)

-- DeskTime's 52/17 minutes work/break
vim.keymap.set("n", "<leader>pdw", "<cmd>TimerStart 52m work<CR>", opts)
vim.keymap.set("n", "<leader>pdb", "<cmd>TimerStart 17m break<CR>", opts)

-- DeskTime's updated 112/26 minutes work/break
vim.keymap.set("n", "<leader>puw", "<cmd>TimerStart 112m work<CR>", opts)
vim.keymap.set("n", "<leader>pub", "<cmd>TimerStart 26m break<CR>", opts)

pomodoro.setup({
  -- How often the notifiers are updated.
  update_interval = 1000,

  -- Configure the default notifiers to use for each timer.
  -- You can also configure different notifiers for timers given specific names, see
  -- the 'timers' field below.
  notifiers = {
    -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
    {
      name = "Default",
      opts = {
        -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
        -- continuously displayed. If you only want a pop-up notification when the timer starts
        -- and finishes, set this to false.
        sticky = true,

        -- Configure the display icons:
        title_icon = "󱎫",
        text_icon = "󰄉",
        -- Replace the above with these if you don't have a patched font:
        -- title_icon = "⏳",
        -- text_icon = "⏱️",
      },
    },

    -- The "System" notifier sends a system notification when the timer is finished.
    -- Currently this is only available on MacOS.
    -- Tracking: https://github.com/epwalsh/pomo.nvim/issues/3
    -- { name = "System" },

    -- You can also define custom notifiers by providing an "init" function instead of a name.
    -- See "Defining custom notifiers" below for an example 👇
    -- { init = function(timer) ... end }
  },

  -- Override the notifiers for specific timer names.
  timers = {
    -- For example, use only the "System" notifier when you create a timer called "Break",
    -- e.g. ':TimerStart 2m Break'.
    Break = {
      -- { name = "System" },
      { name = "Default" },
    },
  },
})
