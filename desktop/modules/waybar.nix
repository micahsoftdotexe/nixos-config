{ config, lib, pkgs, modulesPath, nur, inputs, nix-colors, ... }:
{
  waybar = {
			enable = true;
			package = inputs.waybar.packages.${pkgs.system}.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
			settings = [
				{
          "layer": "top",
          "modules-left": [
            // "custom/arch",
            "hyprland/workspaces",
            "hyprland/window",
            "custom/spotify",
            "cava"
          ],
          "modules-center": [
            "clock"
          ],
          "modules-right": [
            "network",
            "network#2",
            "cpu",
            "memory",
            "custom/weather",
            "pulseaudio"
          ],
          "margin-top": 5,
          "margin-left": 5,
          "margin-right": 5,
          // "custom/arch": {
          //   "format": " <span color=\"#5E81AC\"> </span>",
          //   "tooltip": false,
          //   "on-click": "sh $HOME/.config/rofi/powermenu/type-2/powermenu.sh"
          // },
          "hyprland/workspaces": {
            "all-outputs": true,
            "format": "{icon}",
            "active-only": false,
            "persistent_workspaces": {
              "m1d1": [],
              "m1d2": [],
              "m2d1": [],
              "m2d2": [],
              "m3d1": [],
              "m3d2": [],
              "m4d1": [],
              "m4d2": []
            },
            "format-icons" : {
              "default": "󰄰",
              "active": "󰄯"
            }
          },
          "hyprland/window": {
            "max-length": 30,
            "separate-outputs": false
          },
          "clock": {
            "format": "<span color=\"#5E81AC\">󰃰</span>  {:%d.%m.%y 󰇙 %H:%M}"
          },
          "pulseaudio": {
            "format": "{icon}",
            "format-muted": "󰖁",
            "format-icons": {
                "default": ["", "", "󰕾"]
            },
            "on-click": "pamixer -t",
            "on-scroll-up": "pamixer -i 1",
            "on-scroll-down": "pamixer -d 1",
            "on-click-right": "exec pavucontrol",
            "tooltip-format" : "Volume {volume}%"
          },
          "bluetooth": {
            "format": "<span rise='-1000' color='#b4befe'></span> {status}",
            "format-disabled": "", // an empty format will hide the module
            "format-connected": "<span color=\"#8aadf4\"></span> {num_connections}",
            "tooltip-format": "{device_enumerate}",
            "tooltip-format-enumerate-connected": "{device_alias}   {device_address}"
          },
          "cava": {
            "framerate": 60,
            "autosens": 0,
            "sensitivity": 200,
            "bars": 16,
            "lower_cutoff_freq": 50,
            "higher_cutoff_freq": 10000,
            "method": "pulse",
            "source": "auto",
            "stereo": true,
            "reverse": false,
            "bar_delimiter": 0,
            "monstercat": false,
            "waves": true,
            "noise_reduction": 0.77,
            "input_delay": 2,
            "format-icons" : ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" ],
            "actions": {
                        "on-click-right": "mode"
                        }
          },
          "network": {
            "interface": "enp5s0",
            "interval": 2,
            "format": "{ifname}",
            "format-ethernet": "<span rise='-1500' color=\"#c6a0f6\">󰌗 LAN</span> {bandwidthUpBytes}",
            "min-length": 0,
            "format-disconnected": "󰲝 No Network",
            "tooltip": false
          },
          "network#2": {
            "interface": "tailscale0",
            "interval": 2,
            "format": "{ifname}",
            "format-ethernet": "<span rise='-1500' color=\"#91d7e3\">󰛳 Tailscale</span> {bandwidthUpBytes}",
            "min-length": 13,
            "format-disconncted": "󰌗 No Network",
            "tooltip": false
          },
          "battery": {
            "format": "{icon} {capacity}%",
            "format-icons": [
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              ""
            ],
            "format-charging": "> {capacity}%",
            "tooltip": false
          },
          "cpu": {
            "interval": 1,
            "format": "<span rise='-1000' color=\"#5E81AC\">󰻠</span>{usage:2}%",
            "min-length": 6
          },
          "memory": {
            "interval": 10,
            "format": "<span rise='-1000' color=\"#5E81AC\">󰍛 </span>{used:0.1f}G",
            "min-length": 6
          },
          "disk": {
            "interval": 1,
            "format": "<span rise='-1000' color=\"#5E81AC\"> </span>{free}"
          },
          "custom/spotify": {
            "exec": "~/.config/waybar/scripts/mediaplayer.sh",
            "format": "󰓇 {}",
            "return-type": "json",
            "on-click": "playerctl -p spotify play-pause",
            "on-scroll-up": "playerctl -p spotify next",
            "on-scroll-down": "playerctl -p spotify previous",
            "exec-if": "pgrep spotify"
          },
          "custom/weather": {
            "exec": "$HOME/.config/waybar/scripts/weather.sh",
            "format": "<span rise='10000'>{}</span>",
            "return-type": "json",
            "interval": 300
          },

          "tray": {
            "icon-size": 28,
            "spacing": 10,
            "tooltip": true
          }
        }
      ];
  };

}










