{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.hyprlandV2.addons.kvantum;
in {
  options.flowstate.desktops.hyprlandV2.addons.kvantum = with types; {
    enable = mkBoolOpt false "Enable or disable kvantum.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
    ];
    flowstate = {
      home.configFile = {
        "Kvantum/" = {
          source = ./Kvantum;
          recursive = true;
        };
      };
    };
  };
}
