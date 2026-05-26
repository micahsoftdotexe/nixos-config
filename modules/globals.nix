{ lib, ... }:
{
  flake.nixosModules.globals =
    { lib, ... }:
    {
      options.globals = {
        repoRoot = lib.mkOption {
          type = lib.types.str;
          description = "Absolute path to the nixos-config repository on disk.";
        };
      };
    };
}
