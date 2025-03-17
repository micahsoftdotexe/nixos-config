{ config, ... }:
{
  services.actual = {
    enable = true;
    settings = {
      port = 1986;
      # hostname = "https://actual.micahsoft.net";
      ACTUAL_DATA_DIR = "/disk0/actual";
    };
  };

  services.nginx.virtualHosts."actual.micahsoft.net" = {
    forceSSL = true;
    useACMEHost = "micahsoft.net";
    locations."/" = {
      proxyPass = "http://127.0.0.1:1986";
    };
  };
}