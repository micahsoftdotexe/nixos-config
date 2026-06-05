{ self, inputs, ... }: {
  flake.nixosModules.micahtUser = { pkgs, ... }: {
    imports = [
      self.nixosModules.micahtHomeManager
    ];
    # services.sunshine = {
    #   enable = true;
    #   # autoStart = true;  # optional: starts Sunshine automatically on login
    #   capSysAdmin = true;
    #   openFirewall = true;
    # };
    users.users.micaht = {
      shell = pkgs.fish;
      isNormalUser = true;
      description = "Micah";
      extraGroups = [ "networkmanager" "wheel" "docker" "kvm" "render" "video" ];
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
        docker-compose
        bruno
        telegram-desktop
        calibre
        libreoffice
      ];
    };
  };
}
