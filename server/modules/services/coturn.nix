{ config, pkgs, inputs, ... }:
{
	services.coturn = rec {
      enable = true;
      lt-cred-mech = true;
      use-auth-secret = true;
      static-auth-secret-file = "${config.age.secrets.coturn_turn_secret.path}";
      realm = "turn.micahsoft.net";
      relay-ips = [
        "100.123.59.107"
      ];
      no-tcp-relay = true;
      extraConfig = "
        cipher-list=\"HIGH\"
        no-loopback-peers
        no-multicast-peers
      ";
      secure-stun = true;
      cert = "${config.security.acme.certs.${realm}.directory}/full.pem";
      pkey = "${config.security.acme.certs.${realm}.directory}/key.pem";
      min-port = 49152;
      max-port = 49999;
    };
}