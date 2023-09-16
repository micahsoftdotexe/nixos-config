{
  description = "An example NixOS configuration";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = { url = "github:nix-community/NUR"; };
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    agenix.url = "github:ryantm/agenix";
    nix-colors.url = "github:misterio77/nix-colors";
    waybar.url = "github:alexays/waybar";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, nur, home-manager, hyprland, nix-colors, agenix, vscode-server,  ... }:
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
            home-manager.extraSpecialArgs = { inherit nix-colors inputs builtins; };
            
            home-manager.sharedModules = [
              agenix.homeManagerModules.default
              # hyprland.homeManagerModules.default
              # {wayland.windowManager.hyprland.enable = true;}
            ];
            nixpkgs.overlays = [
              nur.overlay 
              # (self: super: {
              #   waybar = super.waybar.overrideAttrs (oldAttrs: {
              #     mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
              #   });
              # })
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
	        vscode-server.nixosModules.default
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
