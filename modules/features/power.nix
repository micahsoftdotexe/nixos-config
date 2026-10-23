{ ... }: {
  flake.modules.nixos.power = { pkgs, ... }: {
    services.tuned.enable = true;
  };
}