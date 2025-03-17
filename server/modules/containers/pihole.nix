{config, pkgs, inputs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    # Pi-Hole
    8053
    # DNS
    53
  ];
  networking.firewall.allowedUDPPorts = [
    # DNS
    53
  ];

  virtualisation.oci-containers.containers.pihole = {
    image = "pihole/pihole:2024.07.0";
    volumes = [
      "pihole:/etc/pihole"
      "dnsmasq:/etc/dnsmasq.d"
    ];
    ports = [
      "53:53/tcp"
      "53:53/udp"
      "8053:80"
    ];
    # extraOptions = [
    #   "--network=host"
    # ];
    environment = {
      TZ = "America/Chicago";
      PIHOLE_DNS_1 = "9.9.9.9";
      PIHOLE_DNS_2 = "149.112.112.112";
    };
  };
  virtualisation.oci-containers.containers.pihole2 = {
    image = "pihole/pihole:2025.03.0";
    volumes = [
      "/disk0/pihole/pihole:/etc/pihole"
      "/disk0/pihole/dnsmasq:/etc/dnsmasq.d"
    ];
    ports = [
      "54:53/tcp"
      "54:53/udp"
      "8054:80"
    ];
    # extraOptions = [
    #   "--network=host"
    # ];
    environment = {
      TZ = "America/Chicago";
      FTLCONF_dns_upstreams = "9.9.9.9;149.112.112.112";
      PIHOLE_UID = "913";
      PIHOLE_GID = "913";
    };
    environmentFiles = [
      config.age.secrets.pihole.path
    ];
  };
}
