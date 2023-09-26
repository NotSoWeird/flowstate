{ 
	config,
	pkgs,
	lib,
	... 
}: 
with lib;
with lib.flowstate;
{
	imports = [ ./hardware.nix ];

	flowstate.system.boot.enable = true;

	flowstate.apps.helix.enable = true;

  flowstate.desktops.hyprland.enable = true;
	flowstate.suites.common.enable = true;
	flowstate.suites.development.enable = true;


	system.stateVersion = "23.05";
}
