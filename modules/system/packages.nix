{ inputs, ... }: {
  flake.nixosModules.systemPackages = { pkgs, ... }: {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ]; 
    programs.direnv.enable = true;
    virtualisation.docker.enable = true;
    nixpkgs.config.android_sdk.accept_license = true;
    environment.systemPackages = with pkgs; [
      nemo
      neovim
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ghostty
      git
      android-studio
      android-tools
      abcde
      vlc
      picard

    ];
    services.flatpak = {
      enable = true;
      packages = [
        "us.zoom.Zoom"
        "app.fluxer.Fluxer"
        "com.moonlight_stream.Moonlight"
      ];
    };
  };
}