{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let
  cfg = config.suites.development;
in
{
  options.suites.development = with types; {
    enable = mkBoolOpt false "Enable the development suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      licensor
    ];
  };
}
