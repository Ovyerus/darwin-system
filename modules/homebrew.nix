{ pkgs, ... }:
{
  homebrew.enable = true;
  homebrew.brews = [
    "klog"
    "gh"
  ];
}