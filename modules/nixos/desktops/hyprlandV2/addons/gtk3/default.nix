{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.hyprlandV2.addons.gtk3;
in
{
  options.flowstate.desktops.hyprlandV2.addons.gtk3 = with types; {
    enable = mkBoolOpt false "Enable or disable gtk3.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      environment.systemPackages = with pkgs; [
        gtk3
      ];

      home.configFile = {
        "gtk-3.0/settings.ini".source = ./settings.ini;
      };
    };
  };
}
