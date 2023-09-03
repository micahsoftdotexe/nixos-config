{ config, lib, pkgs, modulesPath, nur, ... }:
{
	nixpkgs.config.allowUnfree = true;
	home = {
		stateVersion = "23.05";
		packages = with pkgs; [etcher gitkraken grails keepassxc slack musescore 
			spotify 
			#kdeconnect
			lutris pixelorama cpu-x vlc vivaldi wget neofetch ardour jetbrains-toolbox heroic pkgs.nur.repos.jakobrs.bobrossquotes
			telegram-desktop wireshark
			gnomeExtensions.gsconnect
			gnomeExtensions.user-themes-x
			pidgin scummvm docker-compose insomnia gimp google-chrome freetube webcord woeusb-ng yuzu];
	};
	# home.stateVersion = "23.05";
	# home.packages = [pkgs.etcher pkgs.gitkraken pkgs.grails pkgs.keepassxc pkgs.slack pkgs.musescore 
	# pkgs.spotify pkgs.kdeconnect
	# pkgs.lutris pkgs.pixelorama pkgs.cpu-x pkgs.vlc pkgs.brave pkgs.wget pkgs.neofetch pkgs.ardour pkgs.jetbrains-toolbox pkgs.heroic pkgs.nur.repos.jakobrs.bobrossquotes
	# pkgs.telegram-desktop pkgs.wireshark];
	programs.vscode = {
		enable = true;
		extensions = with pkgs.vscode-extensions; [
			bbenoist.nix
			ms-vsliveshare.vsliveshare
			
		];
	};
}
