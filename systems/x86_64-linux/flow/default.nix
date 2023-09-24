{ 
	config, 
	pkgs, 
	... 
}: {
	imports = [ ./hardware.nix ];

	system = {
		boot.enable = true;
	};

	suites = {
		desktop.enable = true;
		development.enable = true;
	};

	system.stateVersion = "23.05";
}
