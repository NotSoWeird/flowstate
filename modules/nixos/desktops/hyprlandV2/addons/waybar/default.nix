{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.hyprlandV2.addons.waybar;
in
{
  options.flowstate.desktops.hyprlandV2.addons.waybar = with types; {
    enable = mkBoolOpt false "Enable or disable waybar.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      home.programs.waybar = {
        enable = true;
      };

      home.configFile = {
        "waybar/" = {
          source = ./waybar;
          recursive = true;
        };
      };
    };
  };
}
