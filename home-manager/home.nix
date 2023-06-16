{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [<home-manager/nixos>];
	users.users.micaht = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kate
      qjackctl
    ];
    shell = pkgs.fish;
  };
	#nixpkgs.config.allowUnfree = true;
	home-manager.users.micaht = {pkgs, ...}: {
		nixpkgs.config.allowUnfree = true;
		nixpkgs.config.permittedInsecurePackages = [
			"electron-12.2.3"
		];
		home.stateVersion = "23.05";
		home.packages = [pkgs.etcher pkgs.gitkraken pkgs.grails pkgs.keepassxc pkgs.slack pkgs.musescore 
		pkgs.spotify pkgs.kdeconnect
		pkgs.lutris pkgs.pixelorama pkgs.cpu-x pkgs.vlc pkgs.brave pkgs.wget pkgs.neofetch pkgs.ardour pkgs.jetbrains-toolbox];
		programs.vscode = {
			enable = true;
			extensions = with pkgs.vscode-extensions; [
				bbenoist.nix
				ms-vsliveshare.vsliveshare
				
			];
		};
		#services.docker.enable = true;
		#programs.fish.enable = true;
		#shell = pkgs.fish;
		#users.users.micaht.shell = pkgs.fish;	
	};
	# programs.fish.enable = true;
	# users.users.micaht.shell = pkgs.fish;
}
