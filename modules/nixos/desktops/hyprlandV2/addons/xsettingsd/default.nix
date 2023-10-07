{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.hyprlandV2.addons.xsettingsd;
in
{
  options.flowstate.desktops.hyprlandV2.addons.xsettingsd = with types; {
    enable = mkBoolOpt false "Enable or disable xsettingsd.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      home.services.xsettingsd.enable = true;

      home.configFile = {
        "xsettingsd/xsettingsd.conf".source = ./xsettingsd.conf;
      };
    };
  };
}
