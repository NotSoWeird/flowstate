{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.python3;
in {
  options.flowstate.apps.tools.python3 = with types; {
    enable = mkBoolOpt false "Enable python3";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      python3
    ];
  };
}
