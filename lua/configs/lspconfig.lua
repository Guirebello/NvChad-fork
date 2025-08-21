require("nvchad.configs.lspconfig").defaults()

local vue_language_server_path =
  vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
}

local servers = {
  html = {
    -- allow HTML inside Vue
    -- filetypes = { "html", "vue" },

    -- no HTML lsp inside vue
    filetypes = { "html" },
  },
  cssls = {
    -- allow CSS inside Vue
    -- filetypes = { "css", "scss", "less", "vue" },

    -- no CSS inside Vue
    filetypes = { "css", "scss", "less" },
  },
  vue_ls = {
    filetypes = { "vue" },
    init_options = {
      typescript = {
        tsdk = vim.fn.stdpath("data") ..
          "/mason/packages/typescript-language-server/node_modules/typescript/lib"
      }
    }
  },
  vtsls = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            vue_plugin,
          },
        },
      },
    },
    filetypes = tsserver_filetypes,
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
  eslint = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
    },
    settings = {
      -- auto fix on save
      format = true,
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name) -- nvim v0.11.0+ required
  vim.lsp.config(name, opts) -- nvim v0.11.0+ required
end

-- Auto-fix on save (EslintFixAll is exposed by eslint-lsp (eslint_d))
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.js", "*.jsx", "*.ts", "*.tsx", "*.vue" },
  command = "EslintFixAll",
})

-- local servers = { "html", "cssls" }
-- vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
