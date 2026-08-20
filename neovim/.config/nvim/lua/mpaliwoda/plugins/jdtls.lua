-- Deliberately not in `vim.lsp.enable` in plugins/lsp.lua: jdtls needs a
-- workspace dir per project and Java-only requests the generic client lacks.
return {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
        local jdtls = require("jdtls")
        local mason = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

        local root_markers =
            { "settings.gradle", "settings.gradle.kts", "pom.xml", "build.gradle", "build.gradle.kts", ".git", "mvnw", "gradlew" }

        local function attach()
            local root = vim.fs.root(0, root_markers)

            if not root then
                return
            end

            local workspace = vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(root, ":p:h:t")

            jdtls.start_or_attach({
                cmd = {
                    "jdtls",
                    "-data",
                    workspace,
                    "--jvm-arg=-javaagent:" .. mason .. "/lombok.jar",
                },
                root_dir = root,
                capabilities = require("blink.cmp").get_lsp_capabilities(),
                init_options = {
                    bundles = {},
                },
                settings = {
                    java = {
                        signatureHelp = { enabled = true },
                        contentProvider = { preferred = "fernflower" },
                        eclipse = { downloadSources = true },
                        maven = { downloadSources = true },
                        implementationsCodeLens = { enabled = true },
                        referencesCodeLens = { enabled = true },
                        references = { includeDecompiledSources = true },
                        format = { enabled = true },
                        inlayHints = {
                            parameterNames = { enabled = "all" },
                        },
                        completion = {
                            favoriteStaticMembers = {
                                "org.junit.jupiter.api.Assertions.*",
                                "org.junit.jupiter.api.Assumptions.*",
                                "org.mockito.Mockito.*",
                                "org.mockito.ArgumentMatchers.*",
                                "java.util.Objects.requireNonNull",
                                "java.util.Objects.requireNonNullElse",
                            },
                            importOrder = { "java", "javax", "com", "org" },
                        },
                        sources = {
                            organizeImports = {
                                starThreshold = 9999,
                                staticStarThreshold = 9999,
                            },
                        },
                        codeGeneration = {
                            toString = {
                                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                            },
                            useBlocks = true,
                            hashCodeEquals = { useJava7Objects = true },
                        },
                    },
                },
                on_attach = function(_, bufnr)
                    local opts = { buffer = bufnr, remap = false }

                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

                    vim.keymap.set("n", "<leader>joi", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Organize imports" }))
                    vim.keymap.set("n", "<leader>jev", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
                    vim.keymap.set("n", "<leader>jec", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "Extract constant" }))
                    vim.keymap.set("v", "<leader>jem", function()
                        jdtls.extract_method(true)
                    end, vim.tbl_extend("force", opts, { desc = "Extract method" }))
                    vim.keymap.set("v", "<leader>jev", function()
                        jdtls.extract_variable(true)
                    end, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
                end,
            })
        end

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("nvim-jdtls", { clear = true }),
            pattern = "java",
            callback = attach,
        })

        -- The autocmd misses the buffer that triggered the ft lazy-load.
        attach()
    end,
}
