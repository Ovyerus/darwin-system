{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bitwarden-cli
    ffmpeg_6-full
    git
    nil
    obsidian
    openssh
    wget
    # TODO: the Xcode packages makes us manually download and put it into the Nix store
    # but it seems to contain no reference to our actual result so I don't think `systemPackages`
    # picks it up properly.  Need to see how `requireFile` works and how `systemPackages`
    # works under the hood.
    # darwin.xcode_14_1
  ];

  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Fix problem in nix-darwin relating to $PATH order in fish.
  # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1659465635
  programs.fish.loginShellInit = let
    dquote = str: "\"${str}\"";
    makeBinPathList = map (path: path + "/bin");
  in ''
    fish_add_path --move --prepend --path ${lib.concatMapStringsSep " " dquote (makeBinPathList config.environment.profiles)}
    set fish_user_paths $fish_user_paths
    fish_add_path /opt/homebrew/bin
  '';
}
