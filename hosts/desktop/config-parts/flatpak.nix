{ config, pkgs, ... }:
{
  services = {
    flatpak = {
      enable = true;
       packages = [
        "us.zoom.Zoom"
      ];
    };
  };
}