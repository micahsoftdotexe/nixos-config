{ config, lib, pkgs, modulesPath, nur, inputs, nix-colors, ... }:
{
  programs.waybar = {
			enable = true;
			# package = inputs.waybar.packages.${pkgs.system}.waybar.overrideAttrs (oldAttrs: {
      #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      # });
			settings = [
				{
          layer= "top";
          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
            "custom/spotify"
            "cava"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "network"
            "network#2"
            "cpu"
            "memory"
            "custom/weather"
            "pulseaudio"
          ];
          margin-top = 5;
          margin-left = 5;
          margin-right= 5;
          "hyprland/workspaces" = {
            all-outputs= true;
            format = "{icon}";
            active-only = false;
            persistent_workspaces = {
              m1d1 = [];
              m1d2 = [];
              m2d1 = [];
              m2d2 = [];
              m3d1 = [];
              m3d2 = [];
              m4d1 = [];
              m4d2 = [];
            };
            format-icons = {
              default = "󰄰";
              active  = "󰄯";
            };
          };
          "hyprland/window"= {
            max-length = 30;
            separate-outputs = false;
          };
          clock = {
            format = "<span color=\"#5E81AC\">󰃰</span>  {:%d.%m.%y 󰇙 %I:%M%p}";
          };
          pulseaudio = {
            format = "{icon}";
            format-muted = "󰖁";
            format-icons = {
              default = ["󰕿" "󰖀" "󰕾"];
            };
            on-click = "pamixer -t";
            on-scroll-up = "pamixer -i 1";
            on-scroll-down = "pamixer -d 1";
            on-click-right = "exec pavucontrol";
            tooltip-format = "Volume {volume}%";
          };
          cava = {
            framerate= 60;
            autosens= 0;
            sensitivity= 150;
            bars= 16;
            lower_cutoff_frq = 50;
            higher_cutoff_freq= 10000;
            method = "pulse";
            source= "auto";
            stereo= true;
            reverse = false;
            bar_delimiter= 0;
            monstercat= false;
            waves = true;
            noise_reduction = 0.77;
            input_delay = 2;
            format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
            actions = {
              "on-click-right"= "mode";
            };
          };
          network = {
            interface = "enp5s0";
            interval = 2;
            format = "{ifname}";
            format-ethernet = "<span rise='-1500' color=\"#c6a0f6\">󰌗 LAN</span> {bandwidthUpBytes}";
            min-length = 0;
            format-disconnected = "󰲝 No Network";
            tooltip = false;
          };
          "network#2" = {
            interface = "tailscale0";
            interval = 2;
            format = "{ifname}";
            format-ethernet = "<span rise='-1500' color=\"#91d7e3\">󰛳 Tailscale</span> {bandwidthUpBytes}";
            min-length = 13;
            format-disconncted = "󰌗 No Network";
            tooltip = false;
          };
          cpu= {
            interval = 1;
            format = "<span rise='-1000' color=\"#5E81AC\">󰻠</span>{usage:2}%";
            min-length = 6;
          };
          memory = {
            interval = 10;
            format = "<span rise='-1000' color=\"#5E81AC\">󰍛 </span>{used:0.1f}G";
            min-length = 6;
          };
          disk = {
            interval = 1;
            format = "<span rise='-1000' color=\"#5E81AC\"> </span>{free}";
          };
          "custom/spotify"= {
            exec = "~/.config/waybar/scripts/mediaplayer.sh";
            format = "󰓇 {}";
            return-type = "json";
            on-click = "playerctl -p spotify play-pause";
            on-scroll-up = "playerctl -p spotify next";
            on-scroll-down = "playerctl -p spotify previous";
            exec-if = "pgrep spotify";
          };
          "custom/weather"= {
            exec = "$HOME/weather.sh";
            format = "<span rise='10000'>{}</span>";
            return-type = "json";
            interval = 300;
          };
          tray = {
            icon-size = 28;
            spacing = 10;
            tooltip = true;
          };
        }
      ];
      style = ''
        * {
          font-family: 'Symbols Nerd Font Mono';
          font-size: 16px;
          font-weight: bolder;
        }
        window#waybar {
          background: alpha(#${config.colorScheme.colors.base0B}, 0.25);
          
          border-radius: 10px;
        }
        #workspaces,
        #cava {
          border-radius: 10px;
          background-color: alpha(#${config.colorScheme.colors.base0B}, 0.50);
          color: #${config.colorScheme.colors.base0C};
          margin-top: 5px;
          margin-left: 5px;
          margin-bottom: 5px;
          /* margin-right: 3px; */
          padding-left: 5px;
          padding-right: 5px;

        }

        #workspaces button {
          padding-left: 3px;
          padding-right: 3px;
          background: transparent;
          background-color: transparent;
          color: #${config.colorScheme.colors.base0C};
          border: 0px;
        }

        #cpu,
        #memory,
        #disk,
        #custom-notification {
          border-radius: 10px;
          background-color: alpha(#${config.colorScheme.colors.base0B}, 0.50);;
          background-color: alpha(#${config.colorScheme.colors.base0B}, 0.50);;
          margin-top: 5px;
          margin-bottom: 8px;
          padding-left: 5px;
          padding-right: 5px;
          margin-right: 5px;
        }
        #cpu,
        #memory {
          margin-right: 5px;
          margin-left: 0px;
          padding-right: 10px;
          margin-top: 5px;
          margin-bottom: 8px;
        }

        #clock,
        #cpu,
        #disk,
        #network {
          font-family: 'feather';
          font-family: 'TeX Gyre Heros';
        }

        #tray {
          padding-left: 10px;
          padding-right: 0px;
          margin-top: 5px;
          margin-bottom: 5px;
        }

        #clock,
        #date,
        #pulseaudio,
        #network,
        #custom-weather {
          border-radius: 10px;
          background-color: alpha(#${config.colorScheme.colors.base0B}, 0.50);
          background-color: alpha(#${config.colorScheme.colors.base0B}, 0.50);
          margin-top: 5px;
          margin-bottom: 8px;
          padding-left: 10px;
          padding-right: 10px;
          margin-right: 5px;
        }

        #pulseaudio {
          /* padding-left: 0px;
          padding-right: 0px; */
          margin-bottom: 5px;
        }

        #network,
        #network2
        {
          padding-left: 10px;
          padding-right: 10px;
          margin-left: 0px;
          margin-right: 5px;
        }
        #window,
        #custom-spotify {
          border-radius: 10px;
          margin-left: 5px;
          background-color: alpha(#${config.colorScheme.colors.base0B}, 0.50);
          margin-top: 5px;
          margin-bottom: 5px;
          padding-left: 10px;
          padding-right: 10px;
          font-family: 'TeX Gyre Heros';
        }
        #custom-notification {
          font-family: "NotoSansMono Nerd Font";
          margin-right: 10px;
          padding-right: 20px;
          margin-bottom: 5px;
          margin-top: 5px;
          margin-left: 5px;
        }
      '';
  };

}










