# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.microsoft-surface.kernelVersion = "stable";
  # microsoft-surface.surface-control.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
#   boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "micahtronsurface"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    extraPackages = with pkgs.kdePackages; [
      qtvirtualkeyboard
    ];
    settings = {
      General = {
        InputMethod = "qtvirtualkeyboard";
      };
      InputMethod = {
        DefaultInputMethod = "qtvirtualkeyboard";
      };
      # autoLogin.enable = false;
      # autoLogin.user = "micaht";
    };
  };

  # Set environment variables for SDDM to load virtual keyboard at boot
  environment.etc."sddm.conf.d/virtualkeyboard.conf".text = ''
    [General]
    InputMethod=qtvirtualkeyboard
    
    [InputMethod]
    DefaultInputMethod=qtvirtualkeyboard
  '';

  systemd.services.display-manager.environment = {
    QT_IM_MODULE = "qtvirtualkeyboard";
    QT_VIRTUALKEYBOARD_DESKTOP_DISABLE = "0";
  };
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.iptsd = {
      enable = true;
      config = {
          Config = {
            Processing = "advanced"; 
            BlockOnPalm = true;
            TouchThreshold = 20;
            StabilityThreshold = 0.1;
          };
      };
  };
# Helper function to detect the currently logged-in user (gnome session assumed)
  # systemd.services.enable-osk = {
  #   description = "Enable GNOME On-Screen Keyboard and notify user";
  #   script = ''
  #     USER=$(loginctl list-sessions --no-legend | awk '{print $3}' | head -n 1)
  #     USER_ID=$(id -u "$USER")
  #     USER_ENV="DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus"

  #     # Enable On-Screen Keyboard
  #     sudo -u "$USER" $USER_ENV gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true

  #     # Notify user
  #     sudo -u "$USER" $USER_ENV ${pkgs.libnotify}/bin/notify-send "On-Screen Keyboard Enabled" "Surface keyboard disconnected. Touch keyboard active."
  #   '';
  #   serviceConfig.Type = "oneshot";
  # };

  # systemd.services.disable-osk = {
  #   description = "Disable GNOME On-Screen Keyboard and notify user";
  #   script = ''
  #     USER=$(loginctl list-sessions --no-legend | awk '{print $3}' | head -n 1)
  #     USER_ID=$(id -u "$USER")
  #     USER_ENV="DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus"

  #     # Disable On-Screen Keyboard
  #     sudo -u "$USER" $USER_ENV gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false

  #     # Notify user
  #     sudo -u "$USER" $USER_ENV ${pkgs.libnotify}/bin/notify-send "On-Screen Keyboard Disabled" "Surface keyboard connected. Touch keyboard deactivated."
  #   '';
  #   serviceConfig.Type = "oneshot";
  # };

  # Udev rules for keyboard connect/disconnect
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="input", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="09c0", RUN+="${pkgs.systemd}/bin/systemctl start disable-osk.service"
    ACTION=="remove", SUBSYSTEM=="input", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="09c0", RUN+="${pkgs.systemd}/bin/systemctl start enable-osk.service"
  '';

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.micaht = {
    isNormalUser = true;
    description = "Micah Tanner";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      telegram-desktop
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.direnv.enable = true;
  programs.localsend.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    git
    vscode
    cheese
    surface-control
    kdePackages.plasma-keyboard
    kdePackages.qtvirtualkeyboard
    tidal-hifi
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
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}