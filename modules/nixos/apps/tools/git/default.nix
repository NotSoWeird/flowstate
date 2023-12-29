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
  cfg = config.flowstate.apps.tools.git;
in {
  options.flowstate.apps.tools.git = with types; {
    enable = mkBoolOpt false "Enable or disable git";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [git gh lazygit commitizen];

    flowstate = {
      home.configFile."git/config".source = ./config;
      home.configFile."lazygit/config.yml".source = ./lazygitConfig.yml;
      home.programs.zsh.shellAliases = {
        g = "git";
        ga = "git add";
        gs = "git status";
        gc = "git commit -m";
        gp = "git push";
      };
    };
  };
}
