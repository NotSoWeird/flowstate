{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktop.addons.waybar;
in
{
  options.flowstate.desktop.addons.waybar = with types; {
    enable = mkBoolOpt false "Enable or disable waybar";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.waybar
    ];

    flowstate.home.configFile."waybar/" = {
      recursive = true;
      source = ./config;
    };
  };
}
