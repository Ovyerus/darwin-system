# darwin-system

[nix-darwin](https://github.com/LnL7/nix-darwin) configuration for my MacBooks,
managing things like Homebrew apps, core CLI packages, and other system
configuration. Feel free to pick it apart and adapt for your own system.

For more configuration, check out my
[dotfiles](https://github.com/Ovyerus/dotfiles).

## Usage

Install [Nix](https://nixos.org) and enable the
[`flakes`](https://nixos.org/manual/nix/stable/contributing/experimental-features#xp-feature-flakes)
and
[`nix-command`](https://nixos.org/manual/nix/stable/contributing/experimental-features#xp-feature-nix-command)
experimental features;
[nix-installer](https://github.com/DeterminateSystems/nix-installer) is the
easiest method.

```
git clone https://github.com/Ovyerus/darwin-system.git ~/.config/nix-darwin
nix run nix-darwin -- switch --flake ~/.config/nix-darwin
```

## License

All data in this repository is available in the public domain via the
[Unlicense](./LICENSE). Refer to https://unlicense.org/ for more info.
