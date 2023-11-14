{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.vscode;
in {
  options.flowstate.apps.tools.vscode = with types; {
    enable = mkBoolOpt false "Enable vscode";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscode
    ];

    # flowstate.home.programs.vscode = {
    #   enable = true;
    # };
  };
}
