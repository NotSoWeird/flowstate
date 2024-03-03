{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.cli.onefetch;
in {
  options.flowstate.apps.cli.onefetch = with types; {
    enable = mkBoolOpt false "Enable or disable onefetch";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ onefetch ]; };
}
