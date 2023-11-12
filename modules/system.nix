{ inputs, pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Nix setup
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nix.distributedBuilds = true;

  nix.settings = {
    experimental-features = "nix-command flakes repl-flake";
    builders-use-substitutes = true;
  };

  nix.buildMachines = [
    {
      hostName = "rushing.axolotl-map.ts.net";
      sshUser = "colmena-deploy";
      system = "x86_64-linux";
      speedFactor = 2;
      maxJobs = 6;
      protocol = "ssh-ng";
      # publicHostKey = "";
    }
  ];

  # nix-darwin
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  programs.zsh.enable = true;
  # programs.fish.enable = true;
}