{ config, pkgs, ... }:
{
  services = {
    flatpak = {
      enable = true;
       packages = [
        "us.zoom.Zoom"
        "io.github.nokse22.high-tide"
      ];
    };
  };
}