{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.spotify;
in {
  options.flowstate.apps.spotify = with types; {
    enable = mkBoolOpt false "Enable or disable spotify";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ spotify ]; };
}
