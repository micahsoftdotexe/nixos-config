{ config, ...}:
let
  qbittorrentPort = "8889:8889";
  prowlarr = "9696:9696";
  radarr = "7878:7878";
  sonarr = "8989:8989";
  jellyseerr = "5055:5055";
  readarr = "8787:8787";
  flaresolverr = "8191:8191";
  media = "/disk0/media_data";
  qbittorentConfig = "/disk1/media/qbittorrent";
  jellyseerrConfig = "/disk1/media/jellyseerr";
  prowlarrConfig = "/disk1/media/prowlarr";
  sonarrConfig = "/disk1/media/sonarr";
  radarrConfig = "/disk1/media/radarr";
  readarrConfig = "/disk1/media/readarr";
  flaresolverrConfig = "/disk1/media/flaresolverr";


in {
  systemd.services.init-gluetun-network = {
    description = "Create the network bridge for Immich..";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig.Type = "oneshot";
    script = let dockercli = "${config.virtualisation.docker.package}/bin/docker";
            in ''
              # immich-net network
              check=$(${dockercli} network ls | grep "gluetun-net" || true)
              if [ -z "$check" ]; then
                ${dockercli} network create gluetun-net
              else
                echo "gluetun-net already exists in docker"
              fi
            '';
  };
  virtualisation.oci-containers.containers.gluetun = {
    image = "qmcgaw/gluetun";
    environment = {
      VPN_SERVICE_PROVIDER = "mullvad";
      VPN_TYPE = "wireguard";
      HTTPPROXY = "on";
      SHADOWSOCKS = "on";
      DNS_ADDRESS = "194.242.2.2";
    };
    environmentFiles = [
      config.age.secrets.gluetun.path
    ];
    ports = [
      qbittorrentPort
      prowlarr
      radarr
      sonarr
      jellyseerr
      readarr
      # flaresolverr
    ];
    extraOptions = [
      # "--restart=on-failure"
      "--network=gluetun-net"
      "--pull=always"
      "--cap-add=NET_ADMIN"
      "--device=/dev/net/tun:/dev/net/tun"
    ];

  };
  virtualisation.oci-containers.containers.qbittorrent = {
    image = "lscr.io/linuxserver/qbittorrent:latest";
    volumes = [
      "${qbittorentConfig}:/config"
      "${media}/downloads:/data"
    ];
    dependsOn = [ "gluetun" ];
    environment = {
      PUID = "789";
      PGID = "789";
      UMASK = "0002";
      TZ = "America/Detroit";
      WEBUI_PORT = "8889";
      DOCKER_MODS = "ghcr.io/gilbn/theme.park:qbittorrent";
      TP_THEME = "nord";
    };
    extraOptions = [
      # "--restart=on-failure"
      "--network=container:gluetun"
      "--pull=always"
    ];
  };
  virtualisation.oci-containers.containers.jellyseerr = {
    image = "fallenbagel/jellyseerr:latest";
    volumes = [
      "${jellyseerrConfig}:/app/config"
    ];
    dependsOn = [ "gluetun" ];
    environment = {
      PUID = "789";
      PGID = "789";
      UMASK = "0002";
      TZ = "America/Detroit";
    };
    extraOptions = [
      # "--restart=on-failure"
      "--network=container:gluetun"
      "--pull=always"
    ];
  };
  virtualisation.oci-containers.containers.prowlarr = {
    image = "lscr.io/linuxserver/prowlarr:develop";
    volumes = [
      "${prowlarrConfig}:/config"
    ];
    dependsOn = [ "gluetun" ];
    environment = {
      PUID = "789";
      PGID = "789";
      UMASK = "0002";
      TZ = "America/Detroit";
      WEBUI_PORT = "8889";
      DOCKER_MODS = "ghcr.io/gilbn/theme.park:prowlarr";
      TP_THEME = "nord";
    };
    extraOptions = [
      # "--restart on-failure"
      "--network=container:gluetun"
      "--pull=always"
    ];
  };
  virtualisation.oci-containers.containers.sonarr = {
    image = "lscr.io/linuxserver/sonarr:develop";
    volumes = [
      "${sonarrConfig}:/config"
      "${media}:/data"
    ];
    dependsOn = [ "gluetun" ];
    environment = {
      PUID = "789";
      PGID = "789";
      UMASK = "0002";
      TZ = "America/Detroit";
      DOCKER_MODS = "ghcr.io/gilbn/theme.park:sonarr";
      TP_THEME = "nord";
    };
    extraOptions = [
      # "--restart=on-failure"
      "--network=container:gluetun"
      "--pull=always"
    ];
  };
  virtualisation.oci-containers.containers.radarr = {
    image = "lscr.io/linuxserver/radarr:develop";
    volumes = [
      "${radarrConfig}:/config"
      "${media}:/data"
    ];
    dependsOn = [ "gluetun" ];
    environment = {
      PUID = "789";
      PGID = "789";
      TZ = "America/Detroit";
      DOCKER_MODS = "ghcr.io/gilbn/theme.park:radarr";
      TP_THEME = "nord";
    };
    extraOptions = [
      # "--restart on-failure"
      "--network=container:gluetun"
      "--pull=always"
    ];
  };

  virtualisation.oci-containers.containers.readarr = {
    image = "lscr.io/linuxserver/readarr:develop";
    volumes = [
      "${readarrConfig}:/config"
      "${media}:/data"
    ];
    dependsOn = [ "gluetun" ];
    environment = {
      PUID = "789";
      PGID = "789";
      TZ = "America/Detroit";
      DOCKER_MODS = "ghcr.io/gilbn/theme.park:readarr";
      TP_THEME = "nord";
    };
    extraOptions = [
      # "--restart on-failure"
      "--network=container:gluetun"
      "--pull=always"
    ];
  };
  virtualisation.oci-containers.containers.flaresolverr = {
    image = "ghcr.io/flaresolverr/flaresolverr:latest";
    volumes = [
      "${flaresolverrConfig}:/config"
    ];
    dependsOn = [ "gluetun" ];
    environment = {
      PUID = "789";
      PGID = "789";
      TZ = "America/Detroit";
    };
    extraOptions = [
      # "--restart on-failure"
      "--network=container:gluetun"
      "--pull=always"
    ];
  };
}