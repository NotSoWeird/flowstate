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
  cfg = config.flowstate.apps.cli.fastfetch;
in {
  options.flowstate.apps.cli.fastfetch = with types; {
    enable = mkBoolOpt false "Enable or disable fastfetch";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [fastfetch];

    flowstate.home.programs.fish.shellAliases = {ff = "fastfetch";};

    flowstate.home.configFile."fastfetch/config.jsonc".source = ./config.jsonc;
    flowstate.home.configFile."fastfetch/images/" = {
      source = ./images;
      recursive = true;
    };
  };
}
