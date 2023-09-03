{ config, lib, pkgs, modulesPath, nur, ... }:
{
	nixpkgs.config.allowUnfree = true;
	
	home.stateVersion = "23.05";
	home.packages = [ pkgs.musescore pkgs.kdeconnect pkgs.neofetch pkgs.heroic pkgs.nur.repos.jakobrs.bobrossquotes pkgs.vlc];
	programs.vscode = {
		enable = true;
		extensions = with pkgs.vscode-extensions; [
			bbenoist.nix
			ms-vsliveshare.vsliveshare
			
		];
	};
}