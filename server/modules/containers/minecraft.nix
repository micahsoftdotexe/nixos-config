{ config, pkgs, inputs, ... }: 
{
	virtualisation.oci-containers.containers.minecraft = {
		autoStart = true;
		image = "itzg/minecraft-server:java23";
		ports = ["25565:25565"];
		environment = {
			MOD_PLATFORM = "AUTO_CURSEFORGE";
			CF_PAGE_URL = "https://www.curseforge.com/minecraft/modpacks/all-the-mods-10";
			ENABLE_WHITELIST = "true";
			WHITELIST = "Super_Blueboy";
			EULA = "TRUE";
			VERSION = "1.21.1";
			INIT_MEMORY = "10G";
			MAX_MEMORY = "12G";
		};
		extraOptions = ["--dns=1.1.1.1"];
		environmentFiles = [
      config.age.secrets.minecraft.path
    ];
		volumes = [
			"/disk1/minecraft/atm10:/data"
		];
	};
	# virtualisation.oci-containers.containers.minecraft = {
	# 	autoStart = true;
	# 	image = "itzg/minecraft-server:java23";
	# 	ports = ["25565:25565"];
	# 	environment = {
	# 		# MOD_PLATFORM = "AUTO_CURSEFORGE";
	# 		# CF_PAGE_URL = "https://www.curseforge.com/minecraft/modpacks/all-the-mods-9/files/5564414";
	# 		EULA = "TRUE";
	# 		# VERSION = "1.21.4";
	# 		INIT_MEMORY = "10G";
	# 		MAX_MEMORY = "12G";
	# 	};
	# 	extraOptions = ["--dns=1.1.1.1"];
	# 	# dns = "192.168.1.1";
	# 	environmentFiles = [
  #     config.age.secrets.minecraft.path
  #   ];
	# 	volumes = [
	# 		"/disk1/minecraft/vanilla:/data"
	# 	];
	# };
}
