{ options, config, lib, pkgs, ... }:

with lib;
with lib.flowstate;
let
  cfg = config.flowstate.system.time;
in
{
  options.flowstate.system.time = with types; {
    enable = mkBoolOpt false "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable {
    time.timeZone = "Europe/Stockholm";
  };
}
