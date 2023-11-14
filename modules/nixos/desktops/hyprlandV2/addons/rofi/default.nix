{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.hyprlandV2.addons.rofi;
in {
  options.flowstate.desktops.hyprlandV2.addons.rofi = with types; {
    enable = mkBoolOpt false "Enable or disable rofi.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      home.programs.rofi = {
        enable = true;
      };

      home.configFile = {
        "rofi/" = {
          source = ./rofi;
          recursive = true;
        };
      };
    };
  };
}
