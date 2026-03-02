vim.deprecate = function() end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "--branch=stable", lazyrepo, lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
            vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
    },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        n = { ["q"] = require("telescope.actions").close },
                    },
                },
            })
            vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
            vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
            vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
              vim.api.nvim_create_autocmd("LspAttach", {
                  callback = function(args)
                      local opts = { buffer = args.buf }
                      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                      vim.keymap.set("n", "<leader>s", vim.diagnostic.open_float, opts)
                      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                  end,
              })
            vim.diagnostic.config({
                float = {
                    border = "rounded",  -- or "single", "double", "solid"
                }
            })
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lspconfig.tsserver.setup({ capabilities = capabilities })
        end,
    },

      {
          "hrsh7th/nvim-cmp",
          dependencies = {
              "hrsh7th/cmp-nvim-lsp",
              "hrsh7th/cmp-buffer",
              "hrsh7th/cmp-path",
              "L3MON4D3/LuaSnip",
              "saadparwaiz1/cmp_luasnip",
          },
          config = function()
              local cmp = require("cmp")
              cmp.setup({
            window = {
                    completion = {
                        border = "rounded",
                        scrollbar = false,
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                    },
                    documentation = {
                        border = "rounded",
                        scrollbar = false,
                    },
                },
                  snippet = {
                      expand = function(args)
                          require("luasnip").lsp_expand(args.body)
                      end,
                  },
                  mapping = cmp.mapping.preset.insert({
                      ["<C-Space>"] = cmp.mapping.complete(),
                      ["<CR>"] = cmp.mapping.confirm({ select = true }),
                      ["<Tab>"] = cmp.mapping.select_next_item(),
                      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                  }),
                  sources = {
                      { name = "nvim_lsp" },
                      { name = "buffer" },
                      { name = "path" },
                  },
              })
          end,
      },
})
