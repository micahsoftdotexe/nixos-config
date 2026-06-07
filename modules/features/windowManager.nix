{ self, inputs, ... }: {
  flake.nixosModules.windowManager = { pkgs, ... }: {
    services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
    services.displayManager.sessionPackages = [ inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.default ];

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
    # services.gnome.gnome-keyring.enable = true;
    # security.pam.services.login.enableGnomeKeyring = true;
  };
}
