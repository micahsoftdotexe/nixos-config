{ config, pkgs, inputs, ... }:
{
	services.navidrome = {
		enable = true;
		settings = {
			Address = "127.0.0.1";
			MusicFolder = "/disk0/music/music";
			DataFolder = "/disk0/navidrome/data";
			EnableTranscodingConfig = true;
		};
	};
	services.nginx.virtualHosts."music.micahsoft.net" = {
		useACMEHost = "micahsoft.net";
		forceSSL = true;
		locations."/" = {
			proxyPass = "http://127.0.0.1:4533";
			proxyWebsockets = true;
		};
	};
}