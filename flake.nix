{
  description = "micahsoft's nixos configuration";
  inputs = {
    # systems.url = "github:nix-systems/default-linux";
    # Nixpkgs unstable
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    stylix.url = "github:danth/stylix";

    waybar.url = "github:alexays/waybar";

    # flake-parts = {
    #   url = "github:hercules-ci/flake-parts";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # flake-utils = {
    #   url = "github:numtide/flake-utils";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixos-hardware.url = "github:8bitbuddhist/nixos-hardware/surface-rust-target-spec-fix";
    #Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
    #Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = { self, nixpkgs, hyprland, nixos-hardware, ... }@inputs: let
    username = "micaht";
    system = "x86_64-linux";
    configPath = "/home/${username}/nixos-config";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = pkgs.lib;
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            inputs.nix-flatpak.nixosModules.nix-flatpak
            ./hosts/desktop
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.default
            ./shared
          ];
          specialArgs = { 
            host = "micahtronL";
            inherit self inputs username configPath hyprland;
           };
          
        };
        surface = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            inputs.nix-flatpak.nixosModules.nix-flatpak
            ./hosts/surface
            inputs.home-manager.nixosModules.default
            nixos-hardware.nixosModules.microsoft-surface-pro-intel
            ./shared
          ];
          specialArgs = { 
            host = "surface";
            inherit self inputs username configPath hyprland;
          };
        };
      };
    };
    
}