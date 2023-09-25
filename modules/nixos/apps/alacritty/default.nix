{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.internal; let
  cfg = config.apps.alacritty;
in {
  options.apps.alacritty = with types; {
    enable = mkBoolOpt false "Enable or disable the alacritty terminal.";
  };

  config = mkIf cfg.enable {

    
    
    home.programs.alacritty = {
      enable = true;

      settings = {
        font = {
          normal = {
            family = "Hack";
            style = "Medium";
          };
          size = 12;
        };

        window = {
          padding = {
            x = 12;
            y = 12;
          };
        };
        shell = {
          program = "/usr/bin/env zsh";
        };
      };
    };

    #home.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;
  };
}
