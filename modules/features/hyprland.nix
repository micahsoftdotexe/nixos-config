{ self, inputs, config, ... }:
let
  inherit (config.flake.meta) repoRoot;
in
{
  flake.modules.nixos.hyprland = { pkgs, ... }: {
    # Also registers a Hyprland session with the greeter
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    home-manager.sharedModules = [ self.modules.homeManager.hyprland ];
  };

  flake.modules.homeManager.hyprland =
    { config, lib, ... }:
    let
      cfg = config.hyprland;
    in
    {
      # The package and session come from the nixos half above.
      # The HM hyprland module is not used because it would generate its own config.
      options.hyprland.repoFile = lib.mkOption {
        type = with lib.types; nullOr str;
        default = "config/hypr/hyprland.lua";
        description = "Path to the Hyprland Lua config inside flake.meta.repoRoot. Set to null to leave ~/.config/hypr unmanaged.";
      };

      config = lib.mkIf (cfg.repoFile != null) {
        xdg.configFile."hypr/hyprland.lua".source =
          config.lib.file.mkOutOfStoreSymlink "${repoRoot}/${cfg.repoFile}";
      };
    };
}
