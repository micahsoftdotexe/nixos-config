{ self, inputs, ... }: {
  flake.nixosConfigurations.micahtron = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.micahtronHardware
      self.nixosModules.systemBase
      self.nixosModules.desktopMango
      self.nixosModules.audioPortalPolkit
      self.nixosModules.systemPackages
      self.nixosModules.micahtUser
      inputs.nur.modules.nixos.default
      {
        networking.hostName = "micahtron";
        system.stateVersion = "25.11";
      }
    ];
  };
}