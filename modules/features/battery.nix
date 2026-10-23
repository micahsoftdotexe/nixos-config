{ ... }: {
  flake.modules.nixos.battery = { pkgs, ... }: {
    services.upower.enable = true;
  };
}