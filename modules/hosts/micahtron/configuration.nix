{ self, ... }: {

  flake.nixosModules.micahtronConfiguration = { ... }: {
    imports = [
      self.nixosModules.micahtronHardware
      self.nixosModules.systemBase
      self.nixosModules.desktopMango
      self.nixosModules.audioPortalPolkit
      self.nixosModules.systemPackages
      self.nixosModules.micaht
    ];

    networking.hostName = "micahtron";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11";
  };

}