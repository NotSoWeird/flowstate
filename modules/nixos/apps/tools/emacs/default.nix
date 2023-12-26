{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.emacs;
in {
  options.flowstate.apps.tools.emacs = with types; {
    enable = mkBoolOpt false "Enable emacs";
  };

  config = mkIf cfg.enable {
    flowstate = {
      apps.tools.python3 = enabled;

      home = {
        programs.emacs = {
          package = pkgs.emacs29-pgtk;
          enable = true;
        };
      };
    };
    flowstate.home.configFile."emacs/" = {
        source = ./emacs;
        recursive = true;
      };
  };
}
