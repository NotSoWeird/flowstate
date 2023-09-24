{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.internal; let
  cfg = config.apps.firefox;
in {
  options.apps.firefox = with types; {
    enable = mkBoolOpt false "Enable or disable firefox.";
  };

  config = mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}
