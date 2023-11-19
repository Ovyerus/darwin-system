{pkgs, ...}: {
  homebrew.enable = true;

  homebrew.taps = [
    "jotaen/klog"
    "ovyerus/tap"
  ];

  homebrew.brews = [
    "klog"
    "mas"
  ];

  homebrew.casks = [
    "discord"
    "iterm2"
    "karabiner-elements"
    "maccy"
    "orbstack"
    "visual-studio-code"
  ];

  homebrew.masApps = {
    Bitwarden = 1352778147;
    Keka = 470158793;
    "Yubico Authenticator" = 1497506650;
  };
}
