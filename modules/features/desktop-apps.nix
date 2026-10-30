{ self, inputs, config, ... }:
let
  inherit (config.flake.meta) repoRoot;
in
{
  flake.modules.nixos.desktopApps = { pkgs, ... }: {
    programs.direnv.enable = true;
    programs.gnome-disks.enable = true;
    services.udisks2.enable = true;
    environment.systemPackages = with pkgs; [
      nemo
      neovim
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ghostty
      vlc
      picard
      devenv
      gimp
      inkscape
      libation
      makemkv
      terminator
    ];

    home-manager.sharedModules = [ self.modules.homeManager.desktopApps ];
  };

  flake.modules.homeManager.desktopApps = { config, ... }: {
    # ssh-terminfo installs xterm-ghostty on remote hosts; ssh-env falls back to xterm-256color
    xdg.configFile."ghostty/config.ghostty".source =
      config.lib.file.mkOutOfStoreSymlink "${repoRoot}/config/ghostty/config.ghostty";
  };
}
