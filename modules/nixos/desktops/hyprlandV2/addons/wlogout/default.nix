{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.hyprlandV2.addons.wlogout;
in
{
  options.flowstate.desktops.hyprlandV2.addons.wlogout = with types; {
    enable = mkBoolOpt false "Enable or disable wlogout.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      home.programs.wlogout = {
        enable = true;
      };

      home.configFile = {
        "wlogout/".source = {
          source = ./wlogout;
          recursive = true;
        };
      };
    };
  };
}
