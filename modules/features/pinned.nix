{ inputs, ... }: {
  # Packages broken on current nixos-unstable, taken from an older nixpkgs rev.
  # Remove entries (and the nixpkgs-pinned input) once they build again.
  flake.modules.nixos.pinned = {
    nixpkgs.overlays = [
      (final: prev:
        let
          pinned = import inputs.nixpkgs-pinned {
            inherit (prev.stdenv.hostPlatform) system;
            config.allowUnfree = true;
          };
        in
        {
          # https://github.com/NixOS/nixpkgs/issues/576333
          inherit (pinned) handbrake;
          # makeShellWrapper / pyopenjtalk-plus test failures
          inherit (pinned) hplip calibre open-webui;
        })
    ];
  };
}
