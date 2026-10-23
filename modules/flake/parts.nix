{ inputs, ... }:
{
  # Provides flake.modules.<class>.<name>, so one feature file can define
  # its nixos and homeManager halves side by side.
  imports = [ inputs.flake-parts.flakeModules.modules ];

  systems = [ "x86_64-linux" ];
}
