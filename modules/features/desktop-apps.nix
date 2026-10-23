{ inputs, ... }: {
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
    ];
  };
}
