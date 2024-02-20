{ config, lib, pkgs, modulesPath, nur, ... }:
{
	nixpkgs.config.allowUnfree = true;
	
	home.stateVersion = "23.05";
	home.packages = with pkgs; [ musescore kdeconnect neofetch heroic vlc insomnia obsidian gittyup zoom-us flightgear
		floorp atlauncher
	];
	programs.vscode = {
		enable = true;
		extensions = with pkgs.vscode-extensions; [
			bbenoist.nix
			ms-vsliveshare.vsliveshare
			
		];
	};
}