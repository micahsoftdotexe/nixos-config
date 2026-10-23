{ ... }: {
  flake.modules.nixos.gaming = {
    programs.steam.enable = true;
  };
}
