{ self, ... }: {
  flake.nixosModules.micahtUser = { pkgs, ... }: {
    imports = [
      self.nixosModules.homeManager
    ];
    users.users.micaht = {
      shell = pkgs.fish;
      isNormalUser = true;
      description = "Micah";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        vscode
        brave
        calibre
        localsend
        kdePackages.ark
        nur.repos.Ev357.helium
        appimage-run
        claude-code
      ];
    };
  };
}
