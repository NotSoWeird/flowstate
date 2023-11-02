{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.doom-emacs;
in
{
  options.flowstate.apps.tools.doom-emacs = with types; {
    enable = mkBoolOpt false "Enable doom-emacs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      emacs
    ];

    flowstate.home.file.".doom.d/" = {
      source = ./doom.d;
      recursive = true;
    };
  };
}
