{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.hyprlandV2.addons.swaylock;
in
{
  options.flowstate.desktops.hyprlandV2.addons.swaylock = with types; {
    enable = mkBoolOpt false "Enable or disable swaylock.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      environment.systemPackages = with pkgs; [
        swaylock
      ];

      home.configFile = {
        "swaylock/config".source = ./config;
      };
    };
  };
}
