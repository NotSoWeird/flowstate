{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.hyprland;
in
{
  options.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable Hyprland.";
  };

  config = mkIf cfg.enable {
    hyprland = {
      services.xserver = {
        enable = true;
        
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;

        libinput.enable = true;
      };     
    };
  };
}