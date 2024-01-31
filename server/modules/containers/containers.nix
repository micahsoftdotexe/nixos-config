{ config, pkgs, inputs, ... }:
{
	virtualisation.oci-containers = {
		backend = "podman";
		containers.homeassistant = {
			volumes = [ "/disk1/homeassistant/config:/config" ];
			environment.TZ = "America/New_York";
			image = "ghcr.io/home-assistant/home-assistant:2024.1.5"; # Warning: if the tag does not change, the image will not be updated
			extraOptions = [ 
				"--network=host" 
				"--device=/dev/ttyACM0:/dev/ttyACM0"  # Example, change this to match your own hardware
			];
		};
		containers.audiobookshelf = {
			image = "ghcr.io/advplyr/audiobookshelf:2.7.0";
			ports = ["8001:80"];
			volumes = [ "/disk1/audiobooks/books:/audiobooks" "/disk1/audiobooks/metadata:/metadata" "/disk1/audiobooks/config:/config" ];
		};
		containers.live-sync = {
			image = "couchdb";
			environmentFiles = [
				config.age.secrets.liveSync_env.path
			];
			volumes = [
				"/disk0/liveSync:/opt/couchdb/data"
				"/disk1/nixos-config/server/modules/containers/couchdb.ini:/opt/couchdb/etc/local.ini"
			];
			ports = [
				"5984:5984"
			];

		};
	};
}
