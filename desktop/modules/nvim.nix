{ nixvim, ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
  };
}
