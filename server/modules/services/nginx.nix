{ config, pkgs, inputs, ... }:
{
	services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      virtualHosts = {
        "audiobooks.micahsoft.net" = {
          useACMEHost = "micahsoft.net";
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8001";
            proxyWebsockets = true;
          };
        };
        "jellyfin.micahsoft.net" = {
          useACMEHost = "micahsoft.net";
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8096";
          };
          locations."/socket" = {
            proxyPass = "http://127.0.0.1:8096";
            proxyWebsockets = true;
          };
        };
        "passwords.micahsoft.net" = {
          useACMEHost = "micahsoft.net";
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8000";
          };
        };
        "turn.micahsoft.net" = {
          useACMEHost = config.services.coturn.realm;
          forceSSL = true;
        };
        "matrix.micahsoft.net" = {
          useACMEHost = "micahsoft.net";
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8008";
          };
        };
        "notes.micahsoft.net" = {
          useACMEHost = "micahsoft.net";
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:5984";
            proxyWebsockets = true;
          };
        };
        # "photos.micahsoft.net" = {
        #   useACMEHost = "micahsoft.net";
        #   forceSSL = true;
        #   locations."/" = {
        #     proxyPass = "http://127.0.0.1:2342";
        #     proxyWebsockets = true;
        #   };
        # };
        "photos.micahsoft.net" = {
          useACMEHost = "micahsoft.net";
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:2283";
            proxyWebsockets = true;
          };
        };
      };
    };
}