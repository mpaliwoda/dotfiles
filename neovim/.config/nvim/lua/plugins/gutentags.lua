local g = vim.g

g.gutentags_modules = { 'ctags' }
g.gutentags_project_root = { '.git' }

g.gutentags_generate_on_new = 1
g.gutentags_generate_on_missing = 1
g.gutentags_generate_on_write = 1
g.gutentags_generate_on_empty_buffer = 0

g.gutentags_ctags_extra_args = { '--tag-relative=yes', '--fields=+ailmnS' }
g.gutentags_define_advanced_commands = 1
g.gutentags_cache_dir = os.getenv('HOME') .. '/.cache/tags'


g.gutentags_ctags_exclude = {
    '*-lock.json',
    '*.bak',
    '*.bmp',
    '*.cache',
    '*.class',
    '*.csproj',
    '*.csproj.user',
    '*.css',
    '*.dll',
    '*.doc',
    '*.docx',
    '*.flac',
    '*.gif',
    '*.git',
    '*.hg',
    '*.ico',
    '*.jpg',
    '*.js',
    '*.json',
    '*.jsx',
    '*.less',
    '*.lock',
    '*.map',
    '*.Master',
    '*.md',
    '*.min.*',
    '*.pdb',
    '*.png',
    '*.pyc',
    '*.scss',
    '*.sln',
    '*.svg',
    '*.swo',
    '*.swp',
    '*.tar',
    '*.tar.bz2',
    '*.tar.gz',
    '*.tar.xz',
    '*.tmp',
    '*.ts',
    '*.tsx',
    '*.zip',
    '*.zip',
    '*/tests/*',
    '*sites/*/files/*',
    '.*rc*',
    'bin',
    'build',
    'bundle',
    'cache',
    'compiled',
    'cscope.*',
    'dist',
    'docs',
    'example',
    'node_modules',
    'tags*',
    'vendor',
}
