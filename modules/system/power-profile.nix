{ ... }: {
  flake.nixosModules.powerProfile = { pkgs, ... }: {
    services.tuned.enable = true;
  };
}