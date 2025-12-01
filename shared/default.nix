{ config, host, pkgs, lib, inputs, username, home-manager, ...}: 
{
  imports = [
    ./flatpak.nix
    # ./hyprland.nix
    # ./home
    # ./services.nix
  ];
}