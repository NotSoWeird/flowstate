{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktop.addons.wofi;
in
{
  options.flowstate.desktop.addons.wofi = with types; {
    enable = mkBoolOpt false "Enable or disable the wofi run launcher.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wofi
    ];
    flowstate = {
      home.configFile."wofi/config".source = ./config;
      home.configFile."wofi/style.css".source = ./style.css;
    };
  };
}
