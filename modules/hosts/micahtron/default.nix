{ self, inputs, ... }: {
  flake.nixosConfigurations.micahtron = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.micahtronConfiguration
    ];
  };
}