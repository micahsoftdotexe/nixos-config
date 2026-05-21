{ self, inputs, ... }: {
  flake.nixosConfigurations.micahtron = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.micahtronConfiguration
      inputs.nur.modules.nixos.default
    ];
  };
}