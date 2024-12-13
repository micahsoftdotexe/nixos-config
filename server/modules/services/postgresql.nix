{ config, pkgs, inputs, ... }:
let
	mkPlug = p: p.override { postgresql = config.services.postgresql.package; };
in {
	services.postgresql = {
		enable = true;
		package = pkgs.postgresql_14;
		dataDir = "/disk0/postgresql/14";
		settings.shared_preload_libraries = ["vectors.so"];
		extensions = with pkgs; [ postgresql14Packages.pgvecto-rs ];
	};
}
