{ ... }: {
  flake.modules.nixos.android = { pkgs, ... }: {
    nixpkgs.config.android_sdk.accept_license = true;
    environment.systemPackages = with pkgs; [
      android-studio
      android-tools
    ];
  };
}
