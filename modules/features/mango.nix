{ self, inputs, ... }: {

  flake.nixosModules.mango = { pkgs, lib, ... }: {
    # import any other modules from here
    programs.mango = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.mangoNoctalia;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.mangoNoctalia = inputs.wrapper-modules.wrappers.mangowc.wrap {
      inherit pkgs;
      configFile.path = ../../config/mango/config.conf;
    };
  };
}