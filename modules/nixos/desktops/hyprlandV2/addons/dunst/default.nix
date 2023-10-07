{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.hyprlandV2.addons.dunst;
in
{
  options.flowstate.desktops.hyprlandV2.addons.dunst = with types; {
    enable = mkBoolOpt false "Enable or disable the dunst.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      home = {
        programs.dunst = {
          enable = true;
        };

        configFile."dunst/dunstrc".source = ./dunstrc;
        configFile."dunst/icons/".source = {
          source = ./icons;
          recursive = true;
        };
      };
    };
  };
}
