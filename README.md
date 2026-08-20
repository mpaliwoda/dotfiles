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

The script is idempotent — re-run it any time to pick up new packages.

## Layout

Each top-level directory is a [GNU stow](https://www.gnu.org/software/stow/)
package mirroring its destination:

- `<package>/.config/...` is stowed into `$HOME`
- `<package>/etc/...` is stowed into `/` and is Linux-only (e.g. `dual-keys`)
