{...}:

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
    image = "pihole/pihole:2024.03.2";
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
    };
  };
}
