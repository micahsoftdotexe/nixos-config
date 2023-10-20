{ builtins, config, lib, pkgs, modulesPath, nur, inputs, nix-colors, ... }:
let
  nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
  
in
{

	imports = [
    nix-colors.homeManagerModules.default
		./modules/waybar.nix
		./modules/wofi.nix
  ];
	colorScheme = nix-colors-lib.colorSchemeFromPicture {
    path = ./home-config/wallpapers/pxfuel.jpg;
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
		packages = with pkgs; [etcher gitkraken grails keepassxc slack musescore 
			spotify kdeconnect lutris pixelorama cpu-x vlc vivaldi wget neofetch
			telegram-desktop wireshark ardour jetbrains-toolbox heroic pkgs.nur.repos.jakobrs.bobrossquotes
			pidgin scummvm docker-compose insomnia gimp google-chrome freetube webcord woeusb-ng yuzu
			eww-wayland acpi mpc-cli pavucontrol hyprpicker dunst pulsemixer cava playerctl pamixer
   	 	inputs.agenix.packages.${pkgs.system}.default cemu rpcs3 swww minetest
			ark qpwgraph zrythm lyrebird gitui qgit obsidian
		
		];
		file."colors.txt".text = ''
		#${config.colorScheme.colors.base00}
		#${config.colorScheme.colors.base01}
		#${config.colorScheme.colors.base02}
		#${config.colorScheme.colors.base03}
		#${config.colorScheme.colors.base04}
		#${config.colorScheme.colors.base05}
		#${config.colorScheme.colors.base06}
		#${config.colorScheme.colors.base07}
		#${config.colorScheme.colors.base08}
		#${config.colorScheme.colors.base09}
		#${config.colorScheme.colors.base0A}
		#${config.colorScheme.colors.base0B}
		#${config.colorScheme.colors.base0C}
		#${config.colorScheme.colors.base0D}
		#${config.colorScheme.colors.base0E}
		#${config.colorScheme.colors.base0F}
		
		'';
	};
	programs = {
		kitty = {
			enable = true;
			settings = {
				foreground = "#${config.colorScheme.colors.base05}";
				background = "#${config.colorScheme.colors.base00}";
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
