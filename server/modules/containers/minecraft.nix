{ config, pkgs, inputs, ... }: 
{
	virtualisation.oci-containers.containers.minecraft = {
		autoStart = true;
		image = "itzg/minecraft-server";
		ports = ["25565:25565"];
		environment = {
			MOD_PLATFORM = "AUTO_CURSEFORGE";
			CF_PAGE_URL = "https://www.curseforge.com/minecraft/modpacks/all-the-mods-9/files/5564414";
			EULA = "TRUE";
			VERSION = "1.21";
			INIT_MEMORY = "10G";
			MAX_MEMORY = "12G";
		};
		environmentFiles = [
      config.age.secrets.minecraft.path
    ];
		volumes = [
			"/disk1/minecraft/atm9:/data"
		];
	};
}
