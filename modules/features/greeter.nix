{ inputs, ... }: {
  flake.modules.nixos.greeter = {
    imports = [ inputs.noctalia-greeter.nixosModules.default ];

    services.xserver.enable = true;
    services.displayManager.noctalia-greeter.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
    # services.gnome.gnome-keyring.enable = true;
    # security.pam.services.login.enableGnomeKeyring = true;
  };
}
