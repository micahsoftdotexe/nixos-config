{ config, pkgs, inputs, ... }:
{
	systemd.services.init-filerun-network-and-files = {
    description = "Create the network bridge for Immich.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig.Type = "oneshot";
    script = let dockercli = "${config.virtualisation.docker.package}/bin/docker";
            in ''
              # immich-net network
              check=$(${dockercli} network ls | grep "immich-net" || true)
              if [ -z "$check" ]; then
                ${dockercli} network create immich-net
              else
                echo "immich-net already exists in podman"
              fi
            '';
  	};
	virtualisation.oci-containers.containers.immich = {
		environmentFiles = [
			config.age.secrets.immich_env.path
		];
		image = "ghcr.io/imagegenius/immich:latest";
		volumes = [
			"/disk0/immich/photos:/photos"
			"/disk0/immich/config:/config"
			"/disk0/immich/machine-learning:/config/machine-learning"
			"/disk0/immich/import:/import"
		];
		ports = ["8081:8080"];
		extraOptions = [ "--network=immich-net" "--gpus=all" ];


	};
	# services.redis.servers."immich" = {
	# 	enable = true;
	# 	port = 6379;
	# };
	virtualisation.oci-containers.containers.redis = {
		autoStart = true;
      	image = "redis";
      	# ports = [ "6379:6379" ];
		extraOptions = [ "--network=immich-net" ];

	};
	virtualisation.oci-containers.containers.postgresimmich = {
		autoStart = true;
		image = "postgres:14";
		# ports = [ "5432:5432" ];
		volumes = [
			"/disk0/immich/database:/var/lib/postgresql/data"
		];
		environment = {
			POSTGRES_USER = "postgres";
			POSTGRES_PASSWORD = "postgres";
			POSTGRES_DB = "immich";
		};
		extraOptions = [ "--network=immich-net" ];
	};

}