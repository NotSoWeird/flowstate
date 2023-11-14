{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.cli.krabby;
in {
  options.flowstate.apps.cli.krabby = with types; {
    enable = mkBoolOpt false "Enable or disable krabby";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      krabby
    ];
  };
}
