{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    iosevka-solai = {
      url = "github:Ovyerus/iosevka-solai";
    };
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs,
    ...
  } @ inputs: {
    darwinConfigurations."shimmer" = nix-darwin.lib.darwinSystem {
      specialArgs = inputs;
      modules = [
        ./modules/homebrew.nix
        ./modules/programs.nix
        ./modules/services.nix
        ./modules/system.nix
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."shimmer".pkgs;
  };
}
