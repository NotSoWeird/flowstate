{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.cli.starship;
in {
  options.flowstate.apps.cli.starship = with types; {
    enable = mkBoolOpt false "Enable starship";
  };

  config = mkIf cfg.enable {
    flowstate.home.programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };

    environment.systemPackages = with pkgs; [starship];

    flowstate.home.configFile."starship.toml".source = ./starship.toml;
  };
}
