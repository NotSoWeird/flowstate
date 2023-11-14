{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.terminal.kitty;
in {
  options.flowstate.apps.terminal.kitty = with types; {
    enable = mkBoolOpt false "Enable the kitty terminal.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];

    flowstate = {
      home.configFile."kitty/" = {
        source = ./kitty;
        recursive = true;
      };
    };
  };
}
