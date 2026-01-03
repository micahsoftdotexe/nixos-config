{config, pkgs, host, username,...}:
{
  ${username} = {
    isNormalUser = true;
    description = "Micah Tanner";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      telegram-desktop
      vivaldi
      brave
      vesktop
      spotify
      vlc
      isle-portable
      docker-compose
      gimp
      qbittorrent
      git
      hyprlauncher
      kitty
      kdePackages.dolphin
      nwg-displays
      hypridle
      hyprlock
      btop
      hyprpaper
      ghostty
      tidal-hifi
      feh
      file-roller
      libation
      # yt-dlg
      # yt-dlp
      python3
    #  thunderbird
    ];
  };
}
