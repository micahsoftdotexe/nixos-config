{ config, pkgs, host, username, ... }:
{
  firewall = {
    enable = true;
    allowedTCPPorts = [ 22 53317 ];
    allowedUDPPorts = [ 53317 ];
  };
  # Enable networking
  networkmanager.enable = true;
  hostName = host; # Define your hostname.
}