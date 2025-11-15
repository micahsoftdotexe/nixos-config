{pkgs, ...}: {
  enable = true;
  package = inputs.waybar.packages.${pkgs.system}.waybar;
  # settings = {
  #   layer = "top";
  #   position = "bottom";
  #   modules-left = [
  #     "custom/logo"
  #     "clock"
  #     "disk"
  #     "memory"
  #     "cpu"
  #     "temerature"
  #   ];
  #   modules-center = [ 
  #     "hyprland/workspaces" 
  #     "mpd" 
  #   ];
  #   modules-right = [
  #     "hyprland/window"
  #     "tray"
  #     "custom/clipboard"
  #     "group/blight"
  #     "idle_inhibitor"
  #     "custom/colorpicker"
  #     "group/audio"
  #     "group/network"
  #   ];


  # };
  #https://github.com/ashish-kus/waybar-minimal/blob/main/src/config.jsonc
  # config = {
  #   "layer" = 50;
  #   "position" = "top";
  #   "modules-left" = [ "sway/workspaces" "sway/mode" "sway/layout" ];
  #   "modules-center" = [ "clock" ];
  #   "modules-right" = [ "pulseaudio" "network" "tray" ];
  #   clock = {
  #     format = "%Y-%m-%d %H:%M";
  #     interval = 60;
  #   };
  #   pulseaudio = {
  #     format = "{icon} {volume}% {mutestatus}";
  #     interval = 2;
  #     on-click = "pavucontrol";
  #   };
  #   network = {
  #     format-connected = "{ifname} {ipaddr}";
  #     format-disconnected = "Disconnected";
  #     interval = 10;
  #   };
  #   tray = {};
  # };
}