{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.hyprlandV2.addons.mangohud;
in
{
  options.flowstate.desktops.hyprlandV2.addons.mangohud = with types; {
    enable = mkBoolOpt false "Enable or disable mangoHud.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      environment.systemPackages = with pkgs; [
        mangohud
      ];

      home.configFile = {
        "MangoHud/MangoHud.conf".source = ./MangoHud.conf;
      };
    };
  };
}
