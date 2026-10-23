{ ... }: {
  flake.modules.nixos.base = { pkgs, ... }: {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    time.timeZone = "America/New_York";

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

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };

    services.gvfs.enable = true;

    nixpkgs.config.allowUnfree = true;
    nix.gc = {
      automatic = true;
      dates = "weekly";
      persistent = true;
      options = "--delete-older-than 3d";
    };
  };
}
