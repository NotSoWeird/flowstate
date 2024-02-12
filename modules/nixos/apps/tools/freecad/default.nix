{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.tools.freecad;
in {
  options.flowstate.apps.tools.freecad = with types; {
    enable = mkBoolOpt false "Enable freecad";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ freecad ]; };
}
