{ config, pkgs, inputs, ... }: 
{
	virtualisation.oci-containers.containers.tardis = {
		autoStart = true;
		image = "itzg/minecraft-server";
		ports = ["25565:25565"];
		environment = {
			EULA = "TRUE";
			TYPE = "FORGE";
			VERSION = "1.19.2";
			INIT_MEMORY = "3G";
			MAX_MEMORY = "10G";
			FORGE_VERSION = "43.3.0";
			REMOVE_OLD_MODS = "false";
		};
		volumes = [
			"/disk1/minecraft/tardis:/data"
		];
	};
}
