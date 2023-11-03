{ config, pkgs, inputs, ... }:
{
	services.navidrome = {
		enable = true;
		settings = {
			Address = "127.0.0.1";
			MusicFolder = "/disk0/music/music";
			DataFolder = "/disk0/music/data";
			EnableTranscodingConfig = true;
			Port = 4544;
		};
	};
	services.nginx.virtualHosts."music.micahsoft.net" = {
		useACMEHost = "micahsoft.net";
		forceSSL = true;
		locations."/" = {
			proxyPass = "http://127.0.0.1:4544";
			proxyWebsockets = true;
		};
	};
}