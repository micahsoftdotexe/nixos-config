{ config, pkgs, host, username, nix-flatpak, home-manager, ... }:

{
  hardware.openrgb.enable = true;
  xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
    #displayManager.lightdm = {
     # enable = true;
      # wayland = true;
      #greeters.slick = {
       # enable = true;
        #theme.name = "material-slick";
      #};
    desktopManager = { cinnamon.enable = true;};
  };
  displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
  # Enable CUPS to print documents.
  printing.enable = true;
  pulseaudio.enable = false;
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  mpd.enable = true;
  # Enable the OpenSSH daemon.
  openssh.enable = true;
  gnome.gnome-keyring.enable = true;
  envfs.enable = true;

}
