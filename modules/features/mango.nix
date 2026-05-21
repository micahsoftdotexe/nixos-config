{ self, inputs, ... }: {

  flake.nixosModules.mango = { pkgs, ... }: {
    programs.mango = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.mangoNoctalia;
    };
  };

  perSystem = { pkgs, ... }: {
    packages.mangoNoctalia = inputs.wrapper-modules.wrappers.mangowc.wrap {
      inherit pkgs;
      configFile.path = ../../config/mango/config.conf;
    };
  };
}