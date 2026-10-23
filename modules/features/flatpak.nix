{ inputs, ... }: {
  flake.modules.nixos.flatpak = {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
    services.flatpak = {
      enable = true;
      packages = [
        "us.zoom.Zoom"
        "app.fluxer.Fluxer"
        "com.moonlight_stream.Moonlight"
        "net.lutris.Lutris"
      ];
    };
  };
}
