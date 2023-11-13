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
    # (iosevka.override {
    #   set = "custom";
    #   privateBuildPlan = import ../fonts/iosevka.nix {
    #     family = "Iosevka Custom";
    #     spacing = "normal";
    #   };
    # })
    # (iosevka.override {
    #   set = "term";
    #   privateBuildPlan = import ../fonts/iosevka.nix {
    #     family = "Iosevka Term";
    #     spacing = "term";
    #   };
    # })
  ];
}