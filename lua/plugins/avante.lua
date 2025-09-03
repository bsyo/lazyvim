return {
  {
    "yetone/avante.nvim",
    lazy = true,
    event = "VeryLazy",
    build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",

    opts = {
      -- provider = "ollama",
      -- vendors = {
      --   ollama = {
      --     __inherited_from = "openai",
      --     api_key_name = "",
      --     endpoint = "http://127.0.0.1:11434/v1",
      --     model = "deepseek-r1:14b-qwen-distill-q8_0",
      --   },
      -- },

      auto_suggestions_provider = "copilot",
      behaviour = {
        auto_suggestions = true,
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
      },
      providers = {
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = "moonshotai/kimi-k2",
        },
        groq = {
          __inherited_from = "openai",
          api_key_name = "GROQ_API_KEY",
          endpoint = "https://api.groq.com/openai/v1/",
          model = "moonshotai/kimi-k2-instruct",
        },
        zai = {
          __inherited_from = "openai",
          endpoint = "https://open.bigmodel.cn/api/paas/v4/",
          model = "glm-4.5",
        },
        ollama = {
          endpoint = "http://127.0.0.1:11434",
          model = "deepseek-r1:14b-qwen-distill-q8_0",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            options = {
              temperature = 0.75,
              num_ctx = 20480,
              keep_alive = "5m",
            },
          },
        },
        copilot = {
          model = "claude-sonnet-4",
          -- extra_request_body = {
          --   temperature = 0,
          --   max_tokens = 8192,
          -- },
        },
      },
      hints = { enabled = false },
      file_selector = {
        provider = "snacks",
        provider_opts = {},
      },
    },

    dependencies = {
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = function(_, ft)
          vim.list_extend(ft, { "Avante" })
        end,
      },
      {
        "folke/which-key.nvim",
        opts = {
          spec = {
            { "<leader>a", group = "ai" },
          },
        },
      },
    },
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
      input = { enabled = false },
      select = { enabled = false },
    },
  },

  {
    "saghen/blink.compat",
    lazy = true,
    opts = {},
    config = function()
      -- monkeypatch cmp.ConfirmBehavior for Avante
      require("cmp").ConfirmBehavior = {
        Insert = "insert",
        Replace = "replace",
      }
    end,
  },

  {
    "saghen/blink.cmp",
    lazy = true,
    opts = {
      sources = {
        default = { "avante_commands", "avante_mentions", "avante_files" },
        providers = {
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90, -- show at a higher priority than lsp
            opts = {},
          },
          avante_files = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 100, -- show at a higher priority than lsp
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000, -- show at a higher priority than lsp
            opts = {},
          },
        },
      },
    },
  },
}
