{ ... }:
{
  flake.homeModules.hyprland =
    { config, lib, repoRoot, ... }:
    let
      cfg = config.hyprland;
    in
    {
      # The package and session come from programs.hyprland in windowManager.nix.
      # The HM hyprland module is not used because it would generate its own config.
      options.hyprland.repoFile = lib.mkOption {
        type = with lib.types; nullOr str;
        default = "config/hypr/hyprland.lua";
        description = "Path to the Hyprland Lua config inside flake.repoRoot. Set to null to leave ~/.config/hypr unmanaged.";
      };

      config = lib.mkIf (cfg.repoFile != null) {
        xdg.configFile."hypr/hyprland.lua".source =
          config.lib.file.mkOutOfStoreSymlink "${repoRoot}/${cfg.repoFile}";
      };
    };
}
