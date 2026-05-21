{ ... }: {
  flake.nixosModules.audioPortalPolkit = { pkgs, ... }: {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    security.polkit.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = [ "wlr" "gtk" ];
    };

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = [
      pkgs.lxqt.lxqt-policykit
    ];
  };
}
