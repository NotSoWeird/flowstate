{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.browser.firefox;
in
{
  options.flowstate.apps.browser.firefox = with types; {
    enable = mkBoolOpt false "Enable or disable firefox.";
  };

  config = mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}
