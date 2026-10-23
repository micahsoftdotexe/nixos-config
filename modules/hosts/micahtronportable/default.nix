{ self, inputs, config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.micahtronportable = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      base
      networking
      audio
      gnome
      flatpak
      bluetooth
      self.modules.nixos.${username}
    ];

    users.users.${username}.packages = with pkgs; [
      brave
      localsend
    ];

    services.flatpak.packages = [
      "org.telegram.desktop"
    ];

    networking.hostName = "micahtronportable";
    system.stateVersion = "25.11";
  };

  flake.nixosConfigurations.micahtronportable = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.modules.nixos.micahtronportable ];
  };
}
