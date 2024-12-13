{ config, ... }:
{
  services.immich = {
    enable = true;
    redis = {
      enable = true;

    };
    database = {
      enable = true;
      createDB = false;
      user = "immich";
      host = "127.0.0.1";
    };
    host = "127.0.0.1";
    machine-learning.enable = true;
    secretsFile = config.age.secrets.immich_nix.path;
    mediaLocation = "/disk0/immich_nix/photos";
    settings.server.externalDomain = "https://photos.micahsoft.net";
  };
}