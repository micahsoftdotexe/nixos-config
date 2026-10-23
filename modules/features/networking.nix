{ ... }: {
  flake.modules.nixos.networking = { pkgs, ... }: {
    networking.networkmanager.enable = true;

    # LocalSend: TCP for file transfer, UDP for multicast device discovery
    networking.firewall.allowedTCPPorts = [ 53317 ];
    networking.firewall.allowedUDPPorts = [ 53317 ];

    # WireGuard tunnels are managed through NetworkManager, e.g.
    #   nmcli connection import type wireguard file wg0.conf
    # Strict reverse-path filtering drops replies routed through the tunnel.
    networking.wireguard.enable = true;
    networking.firewall.checkReversePath = "loose";
    environment.systemPackages = [ pkgs.wireguard-tools ];

    services.tailscale.enable = true;
  };
}
