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
  cfg = config.flowstate.apps.discord;
in {
  options.flowstate.apps.discord = with types; {
    enable = mkBoolOpt false "Enable or disable discord";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      discord
    ];
  };
}
