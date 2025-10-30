{ config, host, pkgs, lib, inputs, username, home-manager, ...}: 
{
  imports = [
    ./visual-studio-code.nix
    ./flatpak.nix
    ./home-manager.nix
    # ./hyprland.nix
    # ./home
    # ./services.nix
  ];
}