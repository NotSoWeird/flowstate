{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.tools.tangram;
in {
  options.flowstate.apps.tools.tangram = with types; {
    enable = mkBoolOpt false "Enable Tangram";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ tangram ]; };
}
