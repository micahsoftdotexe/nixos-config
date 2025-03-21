{ config, pkgs, inputs, ... }:
{
	virtualisation.oci-containers = {
		backend = "docker";
		containers.homeassistant = {
			volumes = [ "/disk1/homeassistant/config:/config" ];
			environment.TZ = "America/New_York";
			image = "ghcr.io/home-assistant/home-assistant:2025.3.0"; # Warning: if the tag does not change, the image will not be updated
			extraOptions = [ 
				"--network=host" 
				"--device=/dev/ttyACM0:/dev/ttyACM0"  # Example, change this to match your own hardware
			];
		};
		containers.audiobookshelf = {
			image = "ghcr.io/advplyr/audiobookshelf:2.19.5";
			ports = ["8001:80"];
			volumes = [ "/disk0/audiobooks/books:/audiobooks" "/disk0/audiobooks/metadata:/metadata" "/disk0/audiobooks/config:/config" ];
		};
		# containers.root_adminer = {
		# 	image = "adminer";
		# 	extraOptions = [ "--network=host" ];
 	 	# };
	};
}
