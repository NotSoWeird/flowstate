{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.gaming.gamemode;
in {
  options.flowstate.apps.gaming.gamemode = with types; {
    enable = mkBoolOpt false "Enable or disable gamemode.";
  };

  config = mkIf cfg.enable { programs.gamemode.enable = true; };
}
