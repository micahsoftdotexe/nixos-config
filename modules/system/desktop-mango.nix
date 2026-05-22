{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.mangoNoctalia = inputs.wrapper-modules.wrappers.mangowc.wrap {
      inherit pkgs;
      configFile.path = ../../config/mango/config.conf;
    };
  };

  flake.nixosModules.desktopMango = { pkgs, ... }: {
    imports = [
      inputs.mangowm.nixosModules.mango
    ];

    programs.mango = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.mangoNoctalia;
    };

    services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    programs.firefox.enable = true;
  };
}
