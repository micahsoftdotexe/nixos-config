{ self, inputs, config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.${username} = { pkgs, ... }: {
    imports = [ self.modules.nixos.homeManager ];

    # services.sunshine = {
    #   enable = true;
    #   # autoStart = true;  # optional: starts Sunshine automatically on login
    #   capSysAdmin = true;
    #   openFirewall = true;
    # };
    users.users.${username} = {
      shell = pkgs.fish;
      isNormalUser = true;
      description = config.flake.meta.owner.name;
      extraGroups = [ "networkmanager" "wheel" "kvm" "render" "video" "cdrom" ];
      packages = with pkgs; [
        vscode
        brave
        calibre
        localsend
        kdePackages.ark
        nur.repos.Ev357.helium
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        appimage-run
        claude-code
        pavucontrol
        bruno
        telegram-desktop
        libreoffice
        termsonic
        obsidian
        ffmpeg
        cheese
        handbrake
        libdvdcss
        digikam
      ];
    };

    home-manager.users.${username} = {
      imports = [ self.modules.homeManager.${username} ];
    };
  };

  flake.modules.homeManager.${username} = {
    imports = with self.modules.homeManager; [
      beets
      nvchad
    ];

    home.stateVersion = "25.11";
  };
}
