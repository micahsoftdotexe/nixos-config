{ config, pkgs, inputs, ... }: let
    # https://github.com/mkaito/nixos-configurations
	jvmOpts = concatStringsSep " " [
		"-XX:+UseG1GC"
		"-XX:+ParallelRefProcEnabled"
		"-XX:MaxGCPauseMillis=200"
		"-XX:+UnlockExperimentalVMOptions"
		"-XX:+DisableExplicitGC"
		"-XX:+AlwaysPreTouch"
		"-XX:G1NewSizePercent=40"
		"-XX:G1MaxNewSizePercent=50"
		"-XX:G1HeapRegionSize=16M"
		"-XX:G1ReservePercent=15"
		"-XX:G1HeapWastePercent=5"
		"-XX:G1MixedGCCountTarget=4"
		"-XX:InitiatingHeapOccupancyPercent=20"
		"-XX:G1MixedGCLiveThresholdPercent=90"
		"-XX:G1RSetUpdatingPauseTimePercent=5"
		"-XX:SurvivorRatio=32"
		"-XX:+PerfDisableSharedMem"
		"-XX:MaxTenuringThreshold=1"
	];

	defaults = {
		# So I don't have to make everyone op
		spawn-protection = 0;

		# 5 minutes tick timeout, for heavy packs
		max-tick-time = 5 * 60 * 1000;

		# It just ain't modded minecraft without flying around
		allow-flight = true;
	}; in
{
	imports = [inputs.mms.module];

	services.modded-minecraft-servers = {
			eula = true;

			tardis = {
				enable = true;
				jvmOpts = jvmOpts;
				jvmPackage = jre17;
				jvmMaxAllocation = "8G";
        jvmInitialAllocation = "2G";
				serverConfig =
          defaults
          // {
            server-port = 25575;
            motd = "Tardis";
            # Discord plugin should handle this
          };
				};
	};
}
