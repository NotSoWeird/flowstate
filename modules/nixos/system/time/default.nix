{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.system.time;
in
{
  options.system.time = with types; {
    enable = mkBoolOpt false "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable {
    time.timeZone = "Europe/Stockholm";
  };
}
