{ ... }: {
  # Portals and polkit agent for standalone wlroots-style compositors (mango, hyprland).
  # Full desktops like GNOME bring their own.
  flake.modules.nixos.wlrDesktop = { pkgs, ... }: {
    security.polkit.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = [ "wlr" "gtk" ];
    };

    environment.systemPackages = [
      pkgs.lxqt.lxqt-policykit
    ];
  };
}
