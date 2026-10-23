{ self, inputs, config, ... }: {
  flake.modules.nixos.micahtron = {
    imports = with self.modules.nixos; [
      base
      networking
      pinned
      audio
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
      self.modules.nixos.${config.flake.meta.owner.username}
      inputs.nur.modules.nixos.default
    ];

    networking.hostName = "micahtron";
    system.stateVersion = "25.11";
  };

  flake.nixosConfigurations.micahtron = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.modules.nixos.micahtron ];
  };
}
