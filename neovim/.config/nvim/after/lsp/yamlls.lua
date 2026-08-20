return {
    settings = {
        yaml = {
            schemaStore = {
                enable = false,
                url = "",
            },
            rules = {
                ["key-ordering"] = "disable",
            },
            schemas = require("schemastore").yaml.schemas(),
        },
    },
}
