{ ... }: {
  flake.modules.nixos.gnome = { pkgs, ... }: {
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
    environment.systemPackages = with pkgs; [
    	gnomeExtensions.color-picker
    ];
  };
}
