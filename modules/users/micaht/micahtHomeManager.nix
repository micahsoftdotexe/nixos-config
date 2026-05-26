{
  inputs,
  ...
}:
{
  flake.nixosModules.micahtHomeManager =
    {
      config,
      ...
    }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager.backupFileExtension = "backup";
      home-manager.extraSpecialArgs = {
        inherit inputs;
        repoRoot = config.globals.repoRoot;
      };

      home-manager.useGlobalPkgs = true;

      home-manager.users.micaht =
        {
          ...
        }:
        {
          imports = builtins.attrValues inputs.self.homeModules;

          home.stateVersion = "25.11";
        };
    };
}
