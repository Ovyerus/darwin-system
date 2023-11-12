{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ffmpeg
    git
    openssh
  ];
}