{ self, inputs, ... }: {
  flake.nixosConfigurations.micahtron = inputs.nixpkgs.lib.nixosSystem {
    # specialArgs = { inherit inputs; };
    modules = [
      self.nixosModules.globals
      self.nixosModules.micahtronHardware
      self.nixosModules.systemBase
      self.nixosModules.windowManager
      self.nixosModules.audioPortalPolkit
      self.nixosModules.systemPackages
      self.nixosModules.micahtUser
      self.nixosModules.powerProfile
      self.nixosModules.bluetooth
      self.nixosModules.ai
      self.nixosModules.printing
      self.nixosModules.abcde
      inputs.nur.modules.nixos.default
      {
        networking.hostName = "micahtron";
        system.stateVersion = "25.11";
        globals.repoRoot = "/home/micaht/nixos-config";
      }
    ];
  };
}
