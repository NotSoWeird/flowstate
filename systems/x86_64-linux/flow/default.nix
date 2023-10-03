{ 
	lib,
	pkgs,
	... 
}: 
with lib;
{
	imports = [ ./hardware.nix ];

	flowstate = {
		system.boot.enable = true; 

		apps.helix.enable = true;


		suites = {
			desktop.enable = true;
			common.enable = true;
			development.enable = true;
		};
	};


	system.stateVersion = "23.05";
}
