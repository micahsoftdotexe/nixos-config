# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, pkgs, host, username, nix-flatpak, home-manager, ... }:

{
  imports = [
    ./config-parts
  ];
  # imports =
    # [ # Include the results of the hardware scan.
    #   ./hardware-configuration.nix
    # ];

  # Bootloader.
  
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.trusted-users = [ "root" "${username}" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.docker = {
    enable = true;
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the Gnome Desktop Environment.
  services = import ./config-parts/services.nix { inherit config pkgs host username nix-flatpak home-manager; };

  # services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.cinnamon.enable = true;



  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services = {
      login.kwallet.enable = true;
      gdm.kwallet.enable = true;
      gdm-password.kwallet.enable = true;
      hyprlock = { };
      # Unlock GNOME Keyring on login for GVFS credentials
      login.enableGnomeKeyring = true;
      gdm-password.enableGnomeKeyring = true;
    };
  };
  # security.pam.services.hyprland.enableGnomeKeyring = true;
  

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = import ./config-parts/users.nix { inherit config pkgs host username; };

  # services.flatpak.packages = [
  #   "us.zoom.Zoom"
  # ];

  # Install firefox.
  programs = {
    fish.enable = true;
    firefox.enable = true;
    direnv.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default;
      xwayland.enable = true;
      portalPackage =
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
    # hyprland = {
    #   enable = true;
    #   # set the flake package
    #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #   # make sure to also set the portal package, so that they are in sync
    #   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    #   xwayland.enable = true;
    # };

  };

  # hardware.printers = {
  #   ensurePrinters = [
  #     {
  #       name = "Cannon";
  #       location = "Home";
  #       deviceUri = "usb://Canon/TS3700%20series?serial=A1271A";
  #     }
  #   ];
  # };


  fonts.packages = with pkgs; [
    noto-fonts
    ubuntu-classic
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.ubuntu
    mplus-outline-fonts.githubRelease
    dina-font
    fira
  ];


  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita";
        icon-theme = "Flat-Remix-Red-Dark";
        font-name = "Noto Sans Medium 11";
        document-font-name = "Noto Sans Medium 11";
        monospace-font-name = "Noto Sans Mono Medium 11";
      };
    }
  ];




  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.adb.enable = true;
  programs.gnome-disks.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      clinfo
      davinci-resolve
      distrobox
      sqlitestudio
      localsend
      libsecret
      gnome-keyring
      kdePackages.kwallet
      kdePackages.kwallet-pam
      kdePackages.polkit-kde-agent-1
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      hyprpolkitagent
      gvfs
      cpu-x
      gparted
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      openrgb-with-all-plugins
      pavucontrol
      edl
      wget
      unzip
      devenv

    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
  
  # virtualisation.podman = {
  #   enable = true;
  #   dockerCompat = true;
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking = import ./config-parts/networking.nix { inherit config pkgs host username; };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
