{ ... }: {
  flake.nixosModules.battery = { pkgs, ... }: {
    services.upower.enable = true;
  };
}