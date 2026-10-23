{ self, inputs, config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.micahtron = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      base
      networking
      pinned
      audio
      wlrDesktop
      greeter
      mango
      hyprland
      desktopApps
      flatpak
      gaming
      docker
      android
      power
      bluetooth
      ai
      printing
      abcde
      self.modules.nixos.${username}
      inputs.nur.modules.nixos.default
    ];

    users.users.${username}.packages = with pkgs; [
      vscode
      brave
      calibre
      localsend
      kdePackages.ark
      nur.repos.Ev357.helium
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      appimage-run
      claude-code
      pavucontrol
      bruno
      telegram-desktop
      libreoffice
      termsonic
      obsidian
      ffmpeg
      cheese
      handbrake
      libdvdcss
      digikam
    ];

    services.flatpak.packages = [
      "us.zoom.Zoom"
      "app.fluxer.Fluxer"
      "com.moonlight_stream.Moonlight"
      "net.lutris.Lutris"
    ];

    networking.hostName = "micahtron";
    system.stateVersion = "25.11";
  };

  flake.nixosConfigurations.micahtron = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.modules.nixos.micahtron ];
  };
}
