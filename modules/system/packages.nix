{ inputs, ... }: {
  flake.nixosModules.systemPackages = { pkgs, ... }: {
    programs.direnv.enable = true;
    environment.systemPackages = with pkgs; [
      nemo
      neovim
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ghostty
      git
    ];
  };
}
