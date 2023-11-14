{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.nix-ld;
in {
  options.flowstate.apps.tools.nix-ld = with types; {
    enable = mkBoolOpt false "Enable nix-ld";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
