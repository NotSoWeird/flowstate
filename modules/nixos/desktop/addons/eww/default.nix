{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktop.addons.eww;
in
{
  options.flowstate.desktop.addons.eww = with types; {
    enable = mkBoolOpt false "Enable or disable EWW.";
    wayland = mkBoolOpt false "Enable wayland support";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      eww-wayland

      playerctl
      gojq
      jaq
      socat
    ];

    flowstate.home.configFile."eww/" = {
      recursive = true;
      source = ./config;
    };
  };
}
