{ config, ... }: {
  flake.modules.nixos.docker = { pkgs, ... }: {
    virtualisation.docker.enable = true;
    users.users.${config.flake.meta.owner.username} = {
      extraGroups = [ "docker" ];
      packages = [ pkgs.docker-compose ];
    };
  };
}
