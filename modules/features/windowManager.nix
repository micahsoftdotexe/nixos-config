{ self, inputs, ... }: {
  flake.nixosModules.windowManager = { pkgs, ... }: {
    imports = [ inputs.noctalia-greeter.nixosModules.default ];

    services.xserver.enable = true;
    services.displayManager.sessionPackages = [ inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.default ];

    # greetd-based Wayland greeter (replaces lightdm).
    programs.noctalia-greeter.enable = true;
    services.greetd.settings.default_session.user = "greeter";

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
    # services.gnome.gnome-keyring.enable = true;
    # security.pam.services.login.enableGnomeKeyring = true;
  };
}
