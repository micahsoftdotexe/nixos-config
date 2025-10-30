{ config, username, pkgs, lib, inputs, configPath ,home-manager, ... }: 
{
  home-manager = {
    extraSpecialArgs = { inherit inputs username configPath; };
    users.${username} = {
      imports = [
        ./home/home.nix
      ];
    };
      #import ./home.nix { inherit config pkgs username; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}