{ 
	pkgs,
	lib,
	... 
}: 
with lib;
{
	imports = [ ./hardware.nix ];

	flowstate = {
		desktops.hyprland.enable = true;
		suites = {
			common.enable = true;
			development.enable = true;
			desktop.enable = true;
		};
	};
	system.stateVersion = "23.05";
}
