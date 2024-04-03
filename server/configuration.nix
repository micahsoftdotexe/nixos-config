# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, vscode-server, ... }:

{
  # disabledModules = [ "services/audio/navidrome.nix" ];
  imports =
    [ # Include the results of the hardware scan.
      # "${inputs.micahpkgs}/nixos/modules/services/audio/navidrome.nix"
      ./hardware-configuration.nix
      ./modules/containers/containers.nix
      # ./modules/containers/immich.nix
      ./modules/services/coturn.nix
      ./modules/services/nginx.nix
      ./modules/services/matrix.nix
      ./modules/services/postgresql.nix
      ./modules/services/navidrome.nix
      #./modules/services/nextcloud.nix
      ./modules/containers/minecraft.nix
      
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
      liveSync_env = {
        file = ../secrets/liveSync/livesync.env.age;
      };
      liveSync_couch = {
        file = ../secrets/liveSync/couchdb.ini.age;
      };
      immich_env = {
        file = ../secrets/immich/immich.env.age;
      };
      nextcloud_pass = {
        file = ../secrets/nextcloud/nextcloud-pass.age;
        owner = "nextcloud";
      };
      nextcloud_database_pass = {
        file = ../secrets/nextcloud/nextcloud-database-pass.age;
        owner = "nextcloud";
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
      shell = pkgs.fish;
    };
    users.nginx.extraGroups = [ "acme" "turnserver" ];
  };
  services.smartd.enable = true;

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
    vscode-server.enable = true;
    
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
  };
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];
  environment.systemPackages = [ pkgs.tailscale inputs.agenix.packages.x86_64-linux.default pkgs.git pkgs.gitui pkgs.navidrome pkgs.kitty ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs = {
	fish.enable = true;
  	ssh.startAgent = true;
	nixvim = {
		enable = true;
		
	};  
};
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
    interfaces."podman+".allowedUDPPorts = [ 53 ];
    allowedTCPPorts = [ 22 80 443 8123 8000 
      5349  # STUN tls
      5350  # STUN tls alt
      8448
      25565
    ];
    allowedUDPPorts = [
      25565
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

