{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.kdeconnect;
in {
  options.flowstate.apps.kdeconnect = with types; {
    enable = mkBoolOpt false "Enable or disable kdeconnect";
  };

  config = mkIf cfg.enable { programs.kdeconnect.enable = true; };
}
