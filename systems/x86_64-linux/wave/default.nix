{ 
	pkgs,
	lib,
	... 
}: 
with lib;
with lib.flowstate;
{
	imports = [ ./hardware.nix ];

	system.boot.enable = true;

	apps.helix.enable = true;

 	desktops.hyprland.enable = true;
	suites.common.enable = true;
	suites.development.enable = true;


	system.stateVersion = "23.05";
}
