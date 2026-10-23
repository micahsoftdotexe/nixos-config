{ inputs, ... }:
{
  # Features with a homeManager half add it via home-manager.sharedModules,
  # so hosts using them must also include this module.
  flake.modules.nixos.homeManager = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager.useGlobalPkgs = true;
    home-manager.backupFileExtension = "backup";
  };
}
