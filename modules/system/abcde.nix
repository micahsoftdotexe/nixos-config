{ inputs, ... }: {
  flake.nixosModules.abcde = { pkgs, ... }: {
    imports = [ inputs.abcde.nixosModules.default ];
    programs.abcde = {
      enable = true;
      # Use the local flake checkout rather than the module's nixpkgs default.
      package = inputs.abcde.packages.${pkgs.stdenv.hostPlatform.system}.default;
      settings = {
        OUTPUTTYPE = "flac";
        # artist/album/<tracknum>.<title>  (abcde expands these at runtime)
        OUTPUTFORMAT = "\${ARTISTFILE}/\${ALBUMFILE}/\${TRACKNUM}_\${TRACKFILE}";
        # abcde does not eject on its own; opt in. Rendered as EJECTCD=y.
        EJECTCD = true;
      };
    };
  };
}
