{ 
	config,
	pkgs,
	lib, 
	... 
}: 
with lib;
with lib.internal;
{
	imports = [ ./hardware.nix ];

	system = {
		boot.enable = true;
	};

	apps = {
		helix.enable = true;
	};

	suites = {
		desktop.enable = true;
		development.enable = true;
	};

	system.stateVersion = "23.05";
}
