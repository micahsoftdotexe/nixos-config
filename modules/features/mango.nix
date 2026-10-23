{ self, inputs, config, ... }:
let
  inherit (config.flake.meta) repoRoot;
in
{
  flake.modules.nixos.mango = { pkgs, ... }: {
    services.displayManager.sessionPackages = [ inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.default ];

    home-manager.sharedModules = [ self.modules.homeManager.mango ];
  };

  flake.modules.homeManager.mango =
    { config, pkgs, lib, ... }:
    let
      cfg = config.wayland.windowManager.mango;
      useRepoConfig = cfg.repoFile != null;
    in
    {
      imports = [ inputs.mangowm.hmModules.mango ];

      options.wayland.windowManager.mango.repoFile = lib.mkOption {
        type = with lib.types; nullOr str;
        default = "config/mango/config.conf";
        example = "config/mango/laptop.conf";
        description = "Path to the mango config file inside flake.meta.repoRoot. Set to null to use the upstream Home Manager-generated config instead.";
      };

      config = {
        assertions = [
          {
            assertion =
              !useRepoConfig
              || (
                cfg.settings == { }
                && cfg.extraConfig == ""
                && cfg.autostart_sh == ""
              );
            message = "wayland.windowManager.mango.repoFile cannot be used together with settings, extraConfig, or autostart_sh because the repo file fully replaces ~/.config/mango/config.conf.";
          }
        ];

        services.gnome-keyring.enable = true;
        wayland.windowManager.mango.enable = true;
        home.packages = with pkgs; [
          grim
          slurp
          wl-clipboard
        ];

        xdg.configFile."mango/config.conf" = lib.mkIf useRepoConfig {
          source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink "${repoRoot}/${cfg.repoFile}");
        };
      };
    };
}
