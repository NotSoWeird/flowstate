{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.media.nuclear;
in {
  options.flowstate.apps.media.nuclear = with types; {
    enable = mkBoolOpt false "Enable or disable Nuclear";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ nuclear ]; };
}
