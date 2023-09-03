# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, modulesPath, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #<home-manager/nixos>
      # ../home-manager/home.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
           
  # Bootloader.
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        devices = ["nodev"];
        useOSProber = true;

      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    kernelModules = [ "i2c-dev" "i2c-piix4"];
  };
  nixpkgs.overlays = [ inputs.nur.overlay ];
  networking.hostName = "micahtronL"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];
  networking = {
    nameservers = [ "194.242.2.2" ];
    networkmanager.enable = true;
    firewall = {
      enable = true;
      interfaces."tailscale0".allowedTCPPorts = [ 22 80 ];
      allowedTCPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
        { from = 23756; to = 23756; }
        { from = 25565; to = 25565; }
      ];  
      allowedUDPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
        { from = 23756; to = 23756; }
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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
  systemd.user.services.fireRGB = {
    enable = true;
    description = "Starts the fire profile of OpenRGB";
    script = ''
      openrgb -p fire
    '';
    wantedBy = [ "multi-user.target" ];
  };
  services = {
  	xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    # logmein-hamachi.enable = true;
    printing.enable = true;
    printing.drivers = [pkgs.gutenprint pkgs.gutenprintBin];
    hardware.openrgb.enable = true;
    flatpak.enable = true;
    mullvad-vpn.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };
    openssh.enable = true;
    tailscale.enable = true;
  };


  # Enable the X11 windowing system.


  # Configure keymap in X11

  
# Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  #services.jack.enable=true;

  users.users.micaht = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "qemu-libvirtd" "libvirtd" "adbusers" ];
    packages = with pkgs; [
      qjackctl
    ];
    shell = pkgs.fish;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  programs.fish.enable = true;
  programs.adb.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    carla
    firefox
    git
    mullvad-vpn
    unrar
    tailscale
    openrgb-with-all-plugins
    i2c-tools
    jdk17
    distrobox
    virt-manager
    virtiofsd
    libguestfs-with-appliance
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 22];
  #networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
