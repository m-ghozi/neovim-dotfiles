return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
         _________/\     __               
        /   _____/  |__ |__|______  ____  
        \_____  \|  |  \|  |_  __ \/ __ \ 
        /        \      \  ||  | \/  \_\ )
       /_______  /___|  /__||__|   \____/ 
               \/     \/                  
      ]],
        },
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#fb4934" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#fabd2f" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#83a598" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#fe8019" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#b8bb26" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#d3869b" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#458588" })
      end)
      return {
        indent = {
          char = "│",
          tab_char = "│",
          highlight = highlight,
        },
        scope = { show_start = false, show_end = false },
      }
    end,
    main = "ibl",
  },
  {
    "folke/edgy.nvim",
    ---@module 'edgy'
    ---@param opts Edgy.Config
    opts = function(_, opts)
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4 },
          ---title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },
}
