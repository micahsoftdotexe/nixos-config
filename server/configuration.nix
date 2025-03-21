# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, vscode-server, ... }:

{
  # disabledModules = [ "services/audio/immich.nix" ];
  imports =
    [ # Include the results of the hardware scan.
      # "${inputs.micahpkgs}/nixos/modules/services/audio/navidrome.nix"
      ./hardware-configuration.nix
      ./modules/containers/containers.nix
      # ./modules/services/coturn.nix
      ./modules/services/nextcloud.nix
      ./modules/services/nginx.nix
      ./modules/services/actual.nix
      # ./modules/services/matrix.nix
      # ./modules/services/radicale.nix
      ./modules/services/postgresql.nix
      ./modules/services/immich.nix
      ./modules/services/navidrome.nix
      ./modules/containers/pihole.nix
      ./modules/containers/minecraft.nix
      ./modules/containers/gluetun.nix
      # ./modules/containers/go2rtc.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;


  age = {
    secrets = {
      # turn_secret = {
      #   file = ../secrets/matrix/turn_secret.age;
      #   owner = "matrix-synapse";
      #   # identityPaths = "/home/micaht/.ssh/micaht";
      # };
      # coturn_turn_secret = {
      #   file = ../secrets/coturn/coturn_turn_secret.age;
      #   owner = "turnserver";
      #   # identityPaths = "/home/micaht/.ssh/micaht";
      # };
      # postgresql_initial_script = {
      #   file = ../secrets/postgresql/matrix-database.sql.age;
      # };
      liveSync_env = {
        file = ../secrets/liveSync/livesync.env.age;
      };
      liveSync_couch = {
        file = ../secrets/liveSync/couchdb.ini.age;
      };
      immich_env = {
        file = ../secrets/immich/immich.env.age;
      };
      immich_nix = {
        file = ../secrets/immich/immich_nix.env.age;
      };
      immichdb_env = {
        file = ../secrets/immich/immichdb.env.age;
      };
      # radicale = {
      #   file = ../secrets/radicale/htpasswd.age;
      #   owner = "radicale";
      # };
      gluetun = {
        file = ../secrets/gluetun/gluetun.age;
      };
      minecraft = {
        file = ../secrets/minecraft/minecraft.age;
      };
      nextcloud_pass = {
        file = ../secrets/nextcloud/nextcloud-pass.age;
        owner = "nextcloud";
      };
      nextcloud_database_pass = {
        file = ../secrets/nextcloud/nextcloud-database-pass.age;
        owner = "nextcloud";
      };
      pihole = {
        file = ../secrets/pihole/pihole.age;
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
    groups = {
      media = {
        gid = 789;
      };
      go2rtc = {
        gid = 910;
      };
      immich = {
        gid = 912;
      };
      pihole = {
        gid = 913;
      };
    };
    users.micaht = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "media" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        docker-compose
        usbutils
      ];
      shell = pkgs.fish;
    };
    users.media = {
      isNormalUser = false;
      uid = 789;
      group = "media";
    };
    users.go2rtc = {
      isNormalUser = false;
      uid = 910;
      group = "go2rtc";
    };
    users.immich = {
      isNormalUser = false;
      uid = 912;
      group = "immich";
    };
    users.pihole = {
      isNormalUser = false;
      uid = 913;
      group = "pihole";
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
      dnsPropagationCheck = true;
      dnsResolver = "1.1.1.1:53";
      credentialsFile = "/disk0/credentials.secret";
    };
    # certs.${config.services.coturn.realm} = {
    #   dnsProvider = "cloudflare";
    #   dnsPropagationCheck = true;
    #   dnsResolver = "1.1.1.1:53";
    #   credentialsFile = "/disk0/credentials.secret";
    #   postRun = "systemctl restart coturn.service";
    #   group = "turnserver";
    # };
    # certs."matrix.micahsoft.net" = {
    #   dnsProvider = "cloudflare";
    #   dnsPropagationCheck = false;
    #   dnsResolver = "1.1.1.1:53";
    #   credentialsFile = "/disk0/credentials.secret";
    #   postRun = "systemctl restart coturn.service";
    #   group = "turnserver";
    # };

  };
  services = {
    vscode-server.enable = true;
    
    #jellyfin
    jellyfin = {
      enable = true;
      user = "media";
      group = "media";

    };
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
    smartd = {
      enable = true;
      devices = [ {device = "/dev/sda";} {device= "/dev/sdb";} {device= "/dev/sdc";} {device= "/dev/sdd";} ];
    };
  };
  virtualisation = {
    docker.enable = true;
    #podman = {
    #  enable = true;
    #  autoPrune = {
    #    enable = true;
    #    dates = "weekly";
    #  };
    #  defaultNetwork.settings.dns_enabled = true;
    #};
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];
  environment.systemPackages = [ pkgs.tailscale inputs.agenix.packages.x86_64-linux.default pkgs.git pkgs.gitui pkgs.navidrome pkgs.kitty pkgs.cpu-x pkgs.btop ];

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
	neovim.enable = true;
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
    # interfaces."podman+".allowedUDPPorts = [ 53 ];
    # interfaces."tailscale0".allowedTCPPorts = [ 5232 ];
    # interfaces."tailscale0".allowedUDPPorts = [ 5232 ];
    allowedTCPPorts = [ 
      22 
      80 
      443
      1984 #go2rtc
      # 1986 #actual 
      8123 #homeassistant
      2283 #immich
      25565 #minecraft
      5055 #jellyseerr
      8096 #local jelllyfin
      8889 #qbittorrent
      9696 #prowlarr
      8989 #sonarr
      8554 # rtsp go2rtc
      8555 # webrtc go2rtc
      5353 # homekit?
      8090
      8080
    ];
    allowedUDPPorts = [
      # 1986 #actual
      8096 #local jelllyfin
      8123 #homeassistant
      25565 #minecraft
      8090
      8080
      
    ];
    allowedUDPPortRanges = [
      { from = 100; to = 65535;} #home assistant integrations
    ];
    allowedTCPPortRanges = 
    [
	    {from = 100; to = 65535;} #home assistant integrations
    ];
  };

  services.zfs.autoScrub.enable = true;

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

