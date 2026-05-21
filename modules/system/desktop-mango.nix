{ self, inputs, ... }: {
  flake.nixosModules.desktopMango = {
    imports = [
      inputs.mangowm.nixosModules.mango
      self.nixosModules.mango
    ];

    services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    programs.firefox.enable = true;
  };
}
