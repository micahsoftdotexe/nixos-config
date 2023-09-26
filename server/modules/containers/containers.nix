{ config, pkgs, inputs, ... }:
{
	virtualisation.oci-containers = {
		backend = "podman";
		containers.homeassistant = {
			volumes = [ "/disk1/homeassistant/config:/config" ];
			environment.TZ = "America/New_York";
			image = "ghcr.io/home-assistant/home-assistant:2023.8.3"; # Warning: if the tag does not change, the image will not be updated
			extraOptions = [ 
				"--network=host" 
				"--device=/dev/ttyACM0:/dev/ttyACM0"  # Example, change this to match your own hardware
			];
		};
		containers.audiobookshelf = {
			image = "ghcr.io/advplyr/audiobookshelf:2.4.3";
			ports = ["8001:80"];
			volumes = [ "/disk1/audiobooks/books:/audiobooks" "/disk1/audiobooks/metadata:/metadata" "/disk1/audiobooks/config:/config" ];
		};
	};
}