{ inputs, ... }:
{
  flake.homeModules.mango =
    { config, pkgs, lib, repoRoot, ... }:
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
        description = "Path to the mango config file inside flake.repoRoot. Set to null to use the upstream Home Manager-generated config instead.";
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
