{ 
	config,
	pkgs,
	... 
}: {
	imports = [ ./hardware.nix ];

	wayland.windowManager.hyprland.enable = true;
	system.boot.enable = true;

	apps.helix.enable = true;

#	desktops.hyprland.enable = true;
	suites.common.enable = true;
	suites.development.enable = true;


	system.stateVersion = "23.05";
}
