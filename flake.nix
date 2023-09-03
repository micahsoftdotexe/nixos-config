{
  description = "An example NixOS configuration";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nur = { url = "github:nix-community/NUR"; };
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    agenix.url = "github:ryantm/agenix";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, nur, home-manager, hyprland, agenix, ... }:
    /* ignore:: */ let ignoreme = ({config,lib,...}: with lib; { system.nixos.revision = mkForce null; system.nixos.versionSuffix = mkForce "pre-git"; }); in
  {
    nixosConfigurations = {

      desktop = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./desktop/configuration.nix
          # ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.micaht = import ./desktop/home.nix;
            home-manager.sharedModules = [
              hyprland.homeManagerModules.default
              {wayland.windowManager.hyprland.enable = true;}
            ];
            nixpkgs.overlays = [
              nur.overlay 
            ];

          }
          # ./home.nix
          /* ignore */ ignoreme # ignore this; don't include it; it is a small helper for this example
        ];
        specialArgs = { inherit inputs; };
      };
      laptop = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./laptop/configuration.nix
          # ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.micaht = import ./laptop/home.nix;
            nixpkgs.overlays = [
              nur.overlay ];

          }
          # ./home.nix
          /* ignore */ ignoreme # ignore this; don't include it; it is a small helper for this example
        ];
        specialArgs = { inherit inputs; };
      };
      server = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./server/configuration.nix
          agenix.nixosModules.default

        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
