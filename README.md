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

## Layout

Each top-level directory is a [GNU stow](https://www.gnu.org/software/stow/)
package mirroring its destination:

- `<package>/.config/...` is stowed into `$HOME`
- `<package>/etc/...` is stowed into `/` and is Linux-only (e.g. `dual-keys`)
