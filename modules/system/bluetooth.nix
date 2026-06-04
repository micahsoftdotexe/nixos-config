{ ... }: {
  flake.nixosModules.bluetooth = { pkgs, ... }: {
    hardware.bluetooth.enable = true;
  };
}