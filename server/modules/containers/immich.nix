{ config, ... }:

let
  immichRoot = "/disk0/immich"; # TODO: Tweak these to your desired storage locations
  immichPhotos = "${immichRoot}/photos";
  immichAppdataRoot = "${immichRoot}/appdata";
  immichVersion = "release";
  # immichExternalVolume1 = "/tank/BackupData/Google Photos/someone@example.com"; # TODO: if external volumes are desired

  postgresRoot = "${immichAppdataRoot}/pgsql";

in {
 
  # The primary source for this configuration is the recommended docker-compose installation of immich from
  # https://immich.app/docs/install/docker-compose, which linkes to:
  # - https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml
  # - https://github.com/immich-app/immich/releases/latest/download/example.env
  # and has been transposed into nixos configuration here.  Those upstream files should probably be checked
  # for serious changes if there are any upgrade problems here.
  #
  # After initial deployment, these in-process configurations need to be done:
  # - create an admin user by accessing the site
  # - login with the admin user
  # - set the "Machine Learning Settings" > "URL" to http://immich_machine_learning:3003

  virtualisation.oci-containers.containers.immich_server = {
    image = "ghcr.io/immich-app/immich-server:${immichVersion}";
    ports = ["127.0.0.1:2283:3001"];
    extraOptions = [
      "--pull=newer"
      # Force DNS resolution to only be the podman dnsname name server; by default podman provides a resolv.conf
      # that includes both this server and the upstream system server, causing resolutions of other pod names
      # to be inconsistent.
      "--dns=10.88.0.1"
    ];
    cmd = [ "start.sh" "immich" ];
    environment = {
      IMMICH_VERSION = immichVersion;
    };
    environmentFiles = [
			config.age.secrets.immich_env.path
		];
    volumes = [
      "${immichPhotos}:/usr/src/app/upload"
      # "/etc/localtime:/etc/localtime:ro"
      # "${immichExternalVolume1}:${immichExternalVolume1}:ro"
    ];
  };

  virtualisation.oci-containers.containers.immich_microservices = {
    image = "ghcr.io/immich-app/immich-server:${immichVersion}";
    extraOptions = [
      "--pull=newer"
      # Force DNS resolution to only be the podman dnsname name server; by default podman provides a resolv.conf
      # that includes both this server and the upstream system server, causing resolutions of other pod names
      # to be inconsistent.
      "--dns=10.88.0.1"
    ];
    cmd = [ "start.sh" "microservices" ];
    environment = {
      IMMICH_VERSION = immichVersion;
    };
    environmentFiles = [
			config.age.secrets.immich_env.path
		];
    volumes = [
      "${immichPhotos}:/usr/src/app/upload"
      # "/etc/localtime:/etc/localtime:ro"
      # "${immichExternalVolume1}:${immichExternalVolume1}:ro"
    ];
  };

  virtualisation.oci-containers.containers.immich_machine_learning = {
    image = "ghcr.io/immich-app/immich-machine-learning:${immichVersion}";
    extraOptions = ["--pull=newer"];
    environment = {
      IMMICH_VERSION = immichVersion;
    };
    volumes = [
      "${immichAppdataRoot}/model-cache:/cache"
    ];
  };

  virtualisation.oci-containers.containers.immich_redis = {
    image = "registry.hub.docker.com/library/redis:6.2-alpine@sha256:84882e87b54734154586e5f8abd4dce69fe7311315e2fc6d67c29614c8de2672";
  };

  virtualisation.oci-containers.containers.immich_postgres = {
    image = "registry.hub.docker.com/tensorchord/pgvecto-rs:pg14-v0.2.0@sha256:90724186f0a3517cf6914295b5ab410db9ce23190a2d9d0b9dd6463e3fa298f0";
    environmentFiles = [
			config.age.secrets.immichdb_env.path
		];
    volumes = [
      "${postgresRoot}:/var/lib/postgresql/data"
    ];
  };
}