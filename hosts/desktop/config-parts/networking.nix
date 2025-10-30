{ config, pkgs, host, username, ... }:
{
  firewall.enable = true;
  # Enable networking
  networkmanager.enable = true;
  hostName = host; # Define your hostname.
}