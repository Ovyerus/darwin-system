{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ffmpeg
    git
    iterm2
    nixd
    openssh
    wget
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
