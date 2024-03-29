{
  self,
  config,
  iosevka-solai,
  lib,
  nixpkgs,
  pkgs,
  ...
}: {
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  # Nix setup
  services.nix-daemon.enable = true;
  nix.distributedBuilds = true;
  nix.nixPath = ["nixpkgs=${nixpkgs}"];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
    interval.Weekday = 6;
  };

  nix.settings = {
    auto-optimise-store = true;
    builders-use-substitutes = true;
    experimental-features = "nix-command flakes repl-flake";
    trusted-users = ["root" "ovy"];
  };

  nix.buildMachines = [
    {
      hostName = "rushing.axolotl-map.ts.net";
      sshUser = "colmena-deploy";
      system = "x86_64-linux";
      speedFactor = 2;
      maxJobs = 6;
      protocol = "ssh-ng";
    }
    {
      hostName = "skyline.axolotl-map.ts.net";
      sshUser = "colmena-deploy";
      system = "aarch64-linux";
      speedFactor = 1;
      maxJobs = 2;
      protocol = "ssh-ng";
    }
  ];

  # nix-darwin
  system.configurationRevision = self.rev or self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.menuExtraClock.Show24Hour = true;
  system.defaults.trackpad.Dragging = true;

  # Dock settings
  system.defaults.dock = {
    autohide = false;
    magnification = false;
    minimize-to-application = false;
    mru-spaces = false;
    orientation = "bottom";
    show-recents = false;
    tilesize = 48;
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    inter
    iosevka-solai.packages.aarch64-darwin.default
  ];

  # https://github.com/LnL7/nix-darwin/issues/214
}
