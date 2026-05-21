{ inputs, ... }: {
  flake.nixosModules.systemPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      nemo
      neovim
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ghostty
      git
    ];
  };
}
