{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.homeManager =
    {
      ...
    }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager.backupFileExtension = "backup";

      home-manager.useGlobalPkgs = true;

      home-manager.users.micaht =
        {
          ...
        }:
        {
          # all you home modules here
          # imports = [
          # ];

          home.stateVersion = "25.11";
        };
    };
}