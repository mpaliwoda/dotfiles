# dotfiles go brr

## Bootstrap

One command, on a machine with nothing but macOS:

```sh
curl -fsSL https://raw.githubusercontent.com/mpaliwoda/dotfiles/master/bootstrap.sh | bash
```

It clones this repo to `~/dotfiles` (override with `DOTFILES_DIR`) and then
installs Homebrew, runs `brew bundle`, checks out submodules, stows every
package into `$HOME`, installs the mise toolchain, installs tmux plugins and
starts the `borders` service.

Already have the repo checked out? Just run it in place:

```sh
./bootstrap.sh
```

The script is idempotent, so re-run it any time to pick up new packages.

## Work machines

The bootstrap asks whether it is running on a work machine, which decides
whether the work git config, the work mise tools and the work `PATH` entries
get activated. Answer it up front instead:

```sh
./bootstrap.sh --work
./bootstrap.sh --personal
```

`DOTFILES_MACHINE=work|personal` works the same way, which is handy when the
script is piped from curl with no terminal to ask on. The answer is stored in
`~/.config/dotfiles/machine`, is reused as the default on the next run, and is
what `.zshenv` reads to set `IS_WORK_MACHINE`.

## Remote dev machines

A headless box you reach over ssh (RHEL, no GUI, no brew) gets a trimmed
setup:

```sh
curl -fsSL https://raw.githubusercontent.com/mpaliwoda/dotfiles/master/bootstrap.sh | bash -s -- --remote --work
```

What changes with `--remote`:

- System packages come from `dnf`/`yum`, not Homebrew: git, zsh, curl, tar,
  gzip, unzip, xz, make, gcc, gcc-c++ (a compiler is what treesitter parsers
  need). `htop`, `tree` and `stow` are installed only if the enabled repos have
  them. Without `stow` the script links the packages itself, folding
  directories the same way.
- `mise` is installed with its own installer into `~/.local/bin`, and it
  provides `neovim` and `delta`, which the Brewfile covers elsewhere.
- Only the terminal packages are linked: `atuin`, `bat`, `git`, `lsd`, `mise`,
  `neovim`, `starship`, `yazi`, `zsh`. No `tmux`, `ghostty`, `aerospace`,
  `borders` or `dual-keys`, and `.zshrc` never auto-attaches tmux, even if the
  distro ships it.
- The default shell is switched to zsh with `chsh` when there is a terminal
  to type the password on; otherwise the script prints the command to run.

The answer is stored in `~/.config/dotfiles/remote` and reused on re-runs,
just like the work/personal one; `DOTFILES_REMOTE=true|false` or `--local`
override it. With nothing set, the script guesses: Linux over ssh means remote.
Remote and work are independent, so a remote work box gets the work git
config too. `DOTFILES_BRANCH=<branch>` makes a fresh clone check out that
branch instead of master.

Neovim over ssh yanks to the local clipboard through OSC 52 on its own, as
long as `SSH_TTY` is set. Neovim's release binaries need glibc 2.31 or newer,
so on RHEL 8 pin an older `neovim` in `config.remote.toml` or build it from
source.

### mise tool layers

`mise/.config/mise/config.toml` holds the tools every machine gets. On top of
it `MISE_ENV`, which `.zprofile` derives from the two stored answers, loads:

| file                  | when          | what                                   |
| --------------------- | ------------- | -------------------------------------- |
| `config.desktop.toml` | not remote    | colima, docker-compose, lazydocker, go, rust, java, ruby, the cargo tools |
| `config.remote.toml`  | `--remote`    | neovim, delta                          |
| `config.work.toml`    | `--work`      | work-only tools                        |

Language toolchains a project needs still come from that project's own mise
config, so the remote box does not need them globally.

## Layout

Each top-level directory is a [GNU stow](https://www.gnu.org/software/stow/)
package mirroring its destination:

- `<package>/.config/...` is stowed into `$HOME`
- `<package>/etc/...` is stowed into `/` and is Linux-only (e.g. `dual-keys`)
