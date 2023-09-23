{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.workstation;
in
{
  options.workstation = with types; {
    enable = mkBoolOpt false "Whether or not to enable the workstation archetype";
  };

  config = mkIf cfg.enable {
    suites = {
        common = enabled;
        dev = enabled;
    };
  };
}