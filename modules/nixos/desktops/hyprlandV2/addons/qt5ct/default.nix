{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktops.hyprlandV2.addons.qt5ct;
in {
  options.flowstate.desktops.hyprlandV2.addons.qt5ct = with types; {
    enable = mkBoolOpt false "Enable or disable qt5ct.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ libsForQt5.qt5ct ];
    flowstate = {
      home.configFile = {
        "qt5ct/" = {
          source = ./qt5ct;
          recursive = true;
        };
      };
    };
  };
}
