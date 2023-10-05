{ 
	pkgs,
	lib,
	... 
}: 
with lib;
{
	imports = [ ./hardware.nix ];

	flowstate = {
		desktops.hyprland = enabled;
		suites = {
			common = enabled;
			development = enabled;
			desktop = enabled;
		};
	};
	system.stateVersion = "23.05";
}
