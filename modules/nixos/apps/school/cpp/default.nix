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
  cfg = config.flowstate.apps.school.cpp;
in {
  options.flowstate.apps.school.cpp = with types; {
    enable = mkBoolOpt false "Enable or disable cpp.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qtcreator
    ];
  };
}
