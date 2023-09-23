{ pkgs, lib, ... }:

with lib;
{
	imports = [ ./hardware.nix ];

	desktops = {
		#hyprland = enabled;
		gnome = enabled;
	};
	
	archetypes = {
		workstation = enabled;
	};

	system.stateVersion = "23.05";
}
