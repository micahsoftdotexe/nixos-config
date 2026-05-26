{ inputs, ... }:
{
  flake.homeModules.nvchad =
    { ... }:
    {
      imports = [ inputs.nix4nvchad.homeManagerModules.default ];

      programs.nvchad = {
        enable = true;
      };
    };
}
