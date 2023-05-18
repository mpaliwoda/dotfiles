---@alias SuccessCallback fun(module: table): nil
---@alias FailureCallback fun(module_name: string): nil | nil
---@type fun(module_name: string, success_callback: SuccessCallback, failure_callback?: FailureCallback): nil
function prequire(module_name, success_callback, failure_callback)
   local present, module = pcall(require, module_name)

   failure_callback = failure_callback or function(modname)
      vim.notify("Module " .. modname .. " not installed. Run `PlugInstall`.", "error")
   end

   if not present then
      failure_callback(module_name)
      return
   end

   success_callback(module)
end
