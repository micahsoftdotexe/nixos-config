{ config, pkgs, inputs, ... }:
{
	services.matrix-synapse = with config.services.coturn; {
      enable = true;
      settings = {
        enable_registration = true;
        enable_registration_without_verification = true;
        turn_uris = ["turn:turn.micahsoft.net:5349?transport=udp"
                    "turn:turn.micahsoft.net:5350?transport=udp"
                    "turn:turn.micahsoft.net:5349?transport=tcp"
                    "turn:turn.micahsoft.net:5350?transport=tcp"];
        server_name = "micahsoft.net";
        dataDir = "/disk1/matrix-synapse";
        #listeners
        listeners = [
          {
            port = 8008;
            tls = false;
            resources = [
              {
                compress = false;
                names = ["client" "federation"];
              }
            ];
          }
        ];

      };
      extraConfigFiles = [ config.age.secrets.turn_secret.path ];
    };
}