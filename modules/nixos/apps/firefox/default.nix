{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.firefox;
in
{
  options.flowstate.apps.firefox = with types; {
    enable = mkBoolOpt false "Enable or disable firefox.";
  };

  config = mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}
