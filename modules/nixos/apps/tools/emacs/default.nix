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
    environment.systemPackages = with pkgs; [
      emacs29
    ];

    #flowstate.home.configFile."emacs/" = {
    #  source = ./emacs;
    #  recursive = true;
    #};
  };
}
