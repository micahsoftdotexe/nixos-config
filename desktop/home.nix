{ builtins, config, lib, pkgs, modulesPath, nur, inputs, nix-colors, ... }:
let
  nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
  
in
{

	imports = [
    nix-colors.homeManagerModules.default
		./modules/waybar.nix
		./modules/wofi.nix
		# ./modules/plasma.nix
  ];
	colorScheme = nix-colors-lib.colorSchemeFromPicture {
    path = ./home-config/wallpapers/pastel_sky.jpg;
    kind = "dark";
  };
	nixpkgs.config.allowUnfree = true;
	# age = {
	# 		secrets = {
	# 			weather_script = {
	# 				file = ../secrets/waybar/weather.sh.age;
	# 				path = "/weather.sh";
	# 				mode = "555";
	# 			};
	# 		};
	# 	identityPaths = ["/home/micaht/.ssh/micaht" "/home/micaht/.ssh/micahtronL"];
	# };
	 
	home = {
		stateVersion = "23.05";
		packages = with pkgs; [audacity gitkraken keepassxc slack 
			spotify kdeconnect lutris cpu-x vlc vivaldi wget neofetch
			telegram-desktop wireshark ardour jetbrains-toolbox heroic pkgs.nur.repos.jakobrs.bobrossquotes
			scummvm docker-compose insomnia gimp freetube woeusb-ng
			eww acpi mpc-cli pavucontrol hyprpicker dunst pulsemixer cava playerctl pamixer
			inputs.agenix.packages.${pkgs.system}.default rpcs3 swww minetest
			ark qpwgraph obsidian waydroid wl-clipboard ripgrep git-cola jellyfin-media-player chromium gnome.nautilus flightgear
			r2modman gradle minecraft webcord glaxnimate obs-studio
			davinci-resolve btop vesktop floorp libation spotube ollama
		];
		file."colors.txt".text = ''
		#${config.colorScheme.palette.base00}
		#${config.colorScheme.palette.base01}
		#${config.colorScheme.palette.base02}
		#${config.colorScheme.palette.base03}
		#${config.colorScheme.palette.base04}
		#${config.colorScheme.palette.base05}
		#${config.colorScheme.palette.base06}
		#${config.colorScheme.palette.base07}
		#${config.colorScheme.palette.base08}
		#${config.colorScheme.palette.base09}
		#${config.colorScheme.palette.base0A}
		#${config.colorScheme.palette.base0B}
		#${config.colorScheme.palette.base0C}
		#${config.colorScheme.palette.base0D}
		#${config.colorScheme.palette.base0E}
		#${config.colorScheme.palette.base0F}
		
		'';
	};
	programs = {
		kitty = {
			enable = true;
			settings = {
				font_family = "JetBrainsMonoNL Nerd Font";
				foreground = "#${config.colorScheme.palette.base05}";
				background = "#${config.colorScheme.palette.base00}";
				background_opacity = "0.7";
			};
		};
		vscode = {
			enable = true;
			extensions = with pkgs.vscode-extensions; [
				bbenoist.nix
				ms-vsliveshare.vsliveshare
				
			];
		};
	};
}
