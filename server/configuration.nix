# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  age = {
    secrets = {
      turn_secret = {
        file = ../secrets/matrix/turn_secret.age;
        owner = "matrix-synapse";
        # identityPaths = "/home/micaht/.ssh/micaht";
      };
      coturn_turn_secret = {
        file = ../secrets/coturn/coturn_turn_secret.age;
        owner = "turnserver";
        # identityPaths = "/home/micaht/.ssh/micaht";
      };
      postgresql_initial_script = {
        file = ../secrets/postgresql/matrix-database.sql.age;
      };
    };
    identityPaths = ["/home/micaht/.ssh/micaht" "/etc/ssh/micahtronserver"];
  };

  networking.hostName = "micahtronserver"; # Define your hostname.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 8d";
  };  # Set your time zone.
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.micaht = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        docker-compose
        usbutils
      ];
    };
    users.nginx.extraGroups = [ "acme" "turnserver" ];
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "micahrocz777+certs@gmail.com";
    certs."micahsoft.net" = {
      domain = "*.micahsoft.net";
      # extraDomainNames = [ "*.micahsoft.net" ];
      dnsProvider = "cloudflare";
      dnsPropagationCheck = false;
      dnsResolver = "1.1.1.1:53";
      credentialsFile = "/disk1/credentials.secret";
    };
    certs.${config.services.coturn.realm} = {
      dnsProvider = "cloudflare";
      dnsPropagationCheck = false;
      dnsResolver = "1.1.1.1:53";
      credentialsFile = "/disk1/credentials.secret";
      postRun = "systemctl restart coturn.service";
      group = "turnserver";
    };
    # certs."matrix.micahsoft.net" = {
    #   dnsProvider = "cloudflare";
    #   dnsPropagationCheck = false;
    #   dnsResolver = "1.1.1.1:53";
    #   credentialsFile = "/disk1/credentials.secret";
    #   postRun = "systemctl restart coturn.service";
    #   group = "turnserver";
    # };

  };
  services = {

    nginx = {
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
      };
    };

    postgresql = {
      enable = true;
      dataDir = "/disk1/postgresql/14";
      #initialScript = "${config.age.secrets.postgresql_initial_script.path}";
    };

    coturn = rec {
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
    matrix-synapse = with config.services.coturn; {
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
     
      # registration_shared_secret = "1234";
      
    };
    # matrix-synapse = {
    #   enable = 
    # }
    
    #jellyfin
    jellyfin.enable = true;
    vaultwarden = {
      enable = true;
      config = {
        signupsAllowed = false;
      };
    };
    #tailscale
    tailscale =  {
      enable = true;
      # permitCertUid = "caddy";
    };
    #vscode
  };
  virtualisation.oci-containers = {
    backend = "podman";
    containers.homeassistant = {
      volumes = [ "/disk1/homeassistant/config:/config" ];
      environment.TZ = "America/New_York";
      image = "ghcr.io/home-assistant/home-assistant:2023.8.3"; # Warning: if the tag does not change, the image will not be updated
      extraOptions = [ 
        "--network=host" 
        "--device=/dev/ttyACM0:/dev/ttyACM0"  # Example, change this to match your own hardware
      ];
    };
    containers.audiobookshelf = {
      image = "ghcr.io/advplyr/audiobookshelf:2.3.3";
      ports = ["8001:80"];
      volumes = [ "/disk1/audiobooks/books:/audiobooks" "/disk1/audiobooks/metadata:/metadata" "/disk1/audiobooks/config:/config" ];
    };
  }; 

  virtualisation.docker.enable = true;   

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];
  environment.systemPackages = [ pkgs.tailscale inputs.agenix.packages.x86_64-linux.default pkgs.git pkgs.gitui ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.ssh.startAgent = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 80 443 8123 8000 
  #     5349  # STUN tls
  #     5350  # STUN tls alt
  #   ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 8123 8000 
      5349  # STUN tls
      5350  # STUN tls alt
      8448
    ];
    allowedUDPPortRanges = [
      { from=49152; to=49999; } # TURN relay
    ];
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

