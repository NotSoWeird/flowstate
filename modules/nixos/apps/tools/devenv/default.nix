{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.tools.devenv;
in {
  options.flowstate.apps.tools.devenv = with types; {
    enable = mkBoolOpt false "Enable devenv.";
  };

  config = mkIf cfg.enable {
    flowstate.home.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
