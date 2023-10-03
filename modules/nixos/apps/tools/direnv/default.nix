{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.direnv;
in
{
  options.flowstate.apps.tools.direnv = with types; {
    enable = mkBoolOpt false "Enable direnv";
  };

  config = mkIf cfg.enable {
    flowstate.home.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
