{ inputs, ... }: {
  # Apps are added per host via services.flatpak.packages
  flake.modules.nixos.flatpak = {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
    services.flatpak.enable = true;
  };
}
