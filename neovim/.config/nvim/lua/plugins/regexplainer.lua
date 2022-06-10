local present, regexplainer = pcall(require,'regexplainer')

if not present then
    return
end

regexplainer.setup {
  -- 'narrative'
  mode = 'narrative', -- TODO: 'ascii', 'graphical'

  -- automatically show the explainer when the cursor enters a regexp
  auto = true,

  -- filetypes (i.e. extensions) in which to run the autocommand
  filetypes = {
    'html',
    'js',
    'cjs',
    'mjs',
    'ts',
    'jsx',
    'tsx',
    'cjsx',
    'mjsx',
    'python',
  },

  -- Whether to log debug messages
  debug = false, 

  -- 'split', 'popup', 'pasteboard'
  display = 'popup',

  mappings = {
    toggle = 'gR',
    -- examples, not defaults:
    -- show = 'gS',
    -- hide = 'gH',
    -- show_split = 'gP',
    -- show_popup = 'gU',
  },

  narrative = {
    separator = '\n',
  },
}
