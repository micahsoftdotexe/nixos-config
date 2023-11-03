{ config, pkgs, inputs, ... }:
{
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

	};
	# services.redis.servers."immich" = {
	# 	enable = true;
	# 	port = 6379;
	# };
	virtualisation.oci-containers.containers.redis = {
		image = "redis";
		ports = ["6379:6379"];

	};
}