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
    filetypes = { "html", "vue" }, -- allow HTML inside Vue
  },
  cssls = {
    filetypes = { "css", "scss", "less", "vue" }, -- allow CSS inside Vue
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
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name) -- nvim v0.11.0+ required
  vim.lsp.config(name, opts) -- nvim v0.11.0+ required
end
-- local servers = { "html", "cssls" }
-- vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
