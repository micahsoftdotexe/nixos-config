{ config, lib, pkgs, modulesPath, nur, inputs, nix-colors, ... }:
let
  nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
  colorScheme = nix-colors-lib.colorSchemeFromPicture {
    path = ./home-config/wallpapers/pxfuel.jpg;
    kind = "dark";
  };
in
{

	imports = [
    nix-colors.homeManagerModules.default
  ];
	nixpkgs.config.allowUnfree = true;
	home = {
		stateVersion = "23.05";
		packages = with pkgs; [etcher gitkraken grails keepassxc slack musescore 
			spotify 
			kdeconnect
			lutris pixelorama cpu-x vlc vivaldi wget neofetch ardour jetbrains-toolbox heroic pkgs.nur.repos.jakobrs.bobrossquotes
			telegram-desktop wireshark
			pidgin scummvm docker-compose insomnia gimp google-chrome freetube webcord woeusb-ng yuzu
			hyprpaper eww-wayland acpi mpc-cli pavucontrol hyprpicker dunst pulsemixer waybar cava playerctl pamixer
		
		
		];
		file."colors.txt".text = ''
		#${colorScheme.colors.base00}
		#${colorScheme.colors.base01}
		#${colorScheme.colors.base02}
		#${colorScheme.colors.base03}
		#${colorScheme.colors.base04}
		#${colorScheme.colors.base05}
		#${colorScheme.colors.base06}
		#${colorScheme.colors.base07}
		#${colorScheme.colors.base08}
		#${colorScheme.colors.base09}
		#${colorScheme.colors.base0A}
		#${colorScheme.colors.base0B}
		#${colorScheme.colors.base0C}
		#${colorScheme.colors.base0D}
		#${colorScheme.colors.base0E}
		#${colorScheme.colors.base0F}
		
		'';
	}; 
	programs = {
		kitty = {
			enable = true;
			settings = {
				foreground = "#${colorScheme.colors.base05}";
				background = "#${colorScheme.colors.base00}";
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
		wofi = {
			enable = true;
			style = ''
				@define-color clear rgba(0, 0, 0, 0.0);
				@define-color primary rgba(0, 0, 0, 0.75);

				window {
						margin: 2px;
						border: 0px solid;
						background-color: #${colorScheme.colors.base00};
						border-radius: 8px;
				}

				#input {
						padding: 4px;
						margin: 4px;
						border: none;
						color:  #${colorScheme.colors.base0D};
						background-color: #${colorScheme.colors.base09};
						outline: none;
				}

				#inner-box {
						margin: 4px;
						border: 0px solid;
						background-color: @clear;
						border-radius: 8px;
				}

				#outer-box {
						margin: 9px;
						border: none;
						border-radius: 8px;
						background-color: @clear;
				}

				#scroll {
						margin-bottom: 5px;
						margin: 0px;
						border: none;
				}

				#text:selected {
						color: #${colorScheme.colors.base05};
						margin: 0px 0px;
						border: none;
						border-radius: 8px;
				}

				#entry {
						margin: 0px 0px;
						border: none;
						border-radius: 0px;
						/* background-color: transparent;*/
				}

				#entry:selected {
						margin: 0px 0px;
						border: none;
						border-radius: 8px;
					  background-color: #${colorScheme.colors.base0D};
				}
			'';
		};
	};
	# home.stateVersion = "23.05";
	# home.packages = [pkgs.etcher pkgs.gitkraken pkgs.grails pkgs.keepassxc pkgs.slack pkgs.musescore 
	# pkgs.spotify pkgs.kdeconnect
	# pkgs.lutris pkgs.pixelorama pkgs.cpu-x pkgs.vlc pkgs.brave pkgs.wget pkgs.neofetch pkgs.ardour pkgs.jetbrains-toolbox pkgs.heroic pkgs.nur.repos.jakobrs.bobrossquotes
	# pkgs.telegram-desktop pkgs.wireshark];


	# programs.vscode = {
	# 	enable = true;
	# 	extensions = with pkgs.vscode-extensions; [
	# 		bbenoist.nix
	# 		ms-vsliveshare.vsliveshare
			
	# 	];
	# };
}
