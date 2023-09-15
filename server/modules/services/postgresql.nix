{ config, pkgs, inputs, ... }:
{
	services.postgresql = {
		enable = true;
		dataDir = "/disk1/postgresql/14";
		initialScript = "${config.age.secrets.postgresql_initial_script.path}";
	};
}
