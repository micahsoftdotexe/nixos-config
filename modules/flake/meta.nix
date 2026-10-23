{ config, lib, ... }:
{
  # Shared values for every module file, read through its own `config`
  # argument so nothing needs to go through specialArgs.
  options.flake.meta = lib.mkOption {
    type = with lib.types; lazyAttrsOf anything;
  };

  config.flake.meta = {
    owner = {
      username = "micaht";
      name = "Micah";
    };
    repoRoot = "/home/${config.flake.meta.owner.username}/nixos-config";
  };
}
