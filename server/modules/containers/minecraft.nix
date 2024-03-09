{ config, pkgs, inputs, ... }: 
{
	virtualisation.oci-containers.containers.whocraft = {
		autoStart = true;
		image = "itzg/minecraft-server";
		ports = ["25565:25565"];
		environment = {
			EULA = "TRUE";
			TYPE = "FABRIC";
			VERSION = "1.20.1";
			INIT_MEMORY = "4G";
			MAX_MEMORY = "10G";
			FABRIC_VERSION = "0.15.7";
			REMOVE_OLD_MODS = "false";
		};
		volumes = [
			"/disk1/minecraft/whocraft:/data"
		];
	};
}
