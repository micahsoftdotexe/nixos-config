{ config, lib, pkgs, username, configPath, ... }:
let
  hyprlandConfigPath = "~/.config/hypr";
  hyprlandConfigs = builtins.readDir "${configPath}/hosts/desktop/dotfiles/.config/hypr";
in {

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    file = {
      # Individual Hyprland config files
      ".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink
        "${configPath}/hosts/desktop/dotfiles/.config/hypr/hyprland.conf";
      
      ".config/hypr/keybindings.conf".source = config.lib.file.mkOutOfStoreSymlink
        "${configPath}/hosts/desktop/dotfiles/.config/hypr/keybindings.conf";
      
      ".config/hypr/hyprlock.conf".source = config.lib.file.mkOutOfStoreSymlink
        "${configPath}/hosts/desktop/dotfiles/.config/hypr/hyprlock.conf";
      
      # ".config/hypr/hypridle.conf".source = config.lib.file.mkOutOfStoreSymlink
      #   "${configPath}/hosts/desktop/dotfiles/.config/hypr/hypridle.conf";
      
      ".config/hypr/monitors.conf".source = config.lib.file.mkOutOfStoreSymlink
        "${configPath}/hosts/desktop/dotfiles/.config/hypr/monitors.conf";
      
      ".config/hypr/workspaces.conf".source = config.lib.file.mkOutOfStoreSymlink
        "${configPath}/hosts/desktop/dotfiles/.config/hypr/workspaces.conf";
      
      ".config/hypr/windowrules.conf".source = config.lib.file.mkOutOfStoreSymlink
        "${configPath}/hosts/desktop/dotfiles/.config/hypr/windowrules.conf";

      # Other config directories
      ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink
        "${configPath}/hosts/desktop/dotfiles/.config/waybar";

      ".assets".source = config.lib.file.mkOutOfStoreSymlink
        "${configPath}/hosts/desktop/dotfiles/.assets";

        ".vscode/argv.json".source = ../../dotfiles/.vscode/argv.json;
    };
    
  };
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  # };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "${config.home.homeDirectory}/.assets/wallpapers/wallpaper2.png";
      wallpaper = [
        "DP-1,${config.home.homeDirectory}/.assets/wallpapers/wallpaper2.png"
        "DP-2,${config.home.homeDirectory}/.assets/wallpapers/wallpaper2.png"
        "DP-3,${config.home.homeDirectory}/.assets/wallpapers/wallpaper2.png"
        "HDMI-A-1,${config.home.homeDirectory}/.assets/wallpapers/wallpaper2.png"
      ];
      #mode = "fill";
      # interval = 600;
    };
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  programs = {
    home-manager.enable = true;
    waybar.enable = true;
    cava = {
      enable = true;
      settings = {
        general = {
          bars = 20;
          framerate = 30;
          autosens = true;
          sensitivity = 5.0;
          min_decibels = -80.0;
          max_decibels = 0.0;
          min_frequency = 20.0;
          max_frequency = 20000.0;
          smoothing_time_constant = 0.8;
        };
        colors = {
          background = "#161320";
          foreground = "#A6E3A1";
          bar_color = "#89B4FA";
          peak_color = "#F38BA8";
        };
        bars_settings = {
          width = 4;
          spacing = 2;
          type = "bars";
          alignment = "bottom";
          rounded_corners = true;
        };
      };
    };
    # cava.enable = true;
  };
  # programs.home-manager.enable = true;
  # programs.waybar.enable = true;
  # programs.waybar = import ./waybar.nix { inherit pkgs; };
  # programs.vscode = import ./visual-studio-code.nix { inherit pkgs; };

}