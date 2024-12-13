{ config, pkgs, inputs, ... }:
{
	services.calibre-web = {
		enable = true;
		dataDir = "calibre";
    options = {
      calibreLibrary = /disk1/ebooks/books;
			enableBookUploading = true;
    };
		listen.ip = "127.0.0.1";
		listen.port = 9087;
	};
	services.nginx.virtualHosts."ebooks.micahsoft.net" = {
		useACMEHost = "micahsoft.net";
		forceSSL = true;
		locations."/" = {
			proxyPass = "http://127.0.0.1:9087";
			proxyWebsockets = true;
		};
	};
}