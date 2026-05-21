{
  imports = [
    ./system/base.nix
    ./system/desktop-mango.nix
    ./system/audio-portal-polkit.nix
    ./system/packages.nix
  ];

  config = {
    systems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };
}
