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
		packages = with pkgs; [audacity etcher gitkraken keepassxc slack musescore 
			spotify kdeconnect lutris cpu-x vlc vivaldi wget neofetch
			telegram-desktop wireshark ardour jetbrains-toolbox heroic pkgs.nur.repos.jakobrs.bobrossquotes
			scummvm docker-compose insomnia gimp freetube webcord woeusb-ng yuzu
			eww-wayland acpi mpc-cli pavucontrol hyprpicker dunst pulsemixer cava playerctl pamixer
			inputs.agenix.packages.${pkgs.system}.default cemu rpcs3 swww minetest
			ark qpwgraph zrythm obsidian waydroid wl-clipboard ripgrep git-cola jellyfin-media-player chromium gnome.nautilus
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
				font_family = "JetBrainsMonoNL Nerd Font";
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
		neovim = {
			enable = true;
		};
	};
}
