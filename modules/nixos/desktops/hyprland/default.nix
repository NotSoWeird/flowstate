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
      

      addons = {
        wallpapers = enabled;
      };
    };
  };
}