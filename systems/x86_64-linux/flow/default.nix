{ 
	lib,
	pkgs,
	... 
}: 
with lib;
with lib.flowstate;
{
	imports = [ ./hardware.nix ];

	flowstate = {
		system.boot = enabled;

		apps.helix = enabled;

		suites = {
			desktop = enabled;
			common = enabled;
			development = enabled;
		};
	};

	system.stateVersion = "23.05";
}
