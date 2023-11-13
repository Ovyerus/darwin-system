{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ffmpeg
    git
    iterm2
    nixd
    openssh
  ];

  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;

  programs.fish.loginShellInit =
    let
      dquote = str: "\"${str}\"";
      makeBinPathList = map (path: path + "/bin");
    in ''
      fish_add_path --move --prepend --path ${lib.concatMapStringsSep " " dquote (makeBinPathList config.environment.profile)}
      set fish_user_paths $fish_user_paths
    '';
}
