{ config, host, pkgs, lib, inputs, ...}: 
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    # inputs.home-manager.nixosModules.home-manager
  ];
}