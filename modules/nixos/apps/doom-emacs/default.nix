{ config, lib, pkgs, inputs, ... }:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.doom-emacs;
  theme = lib.flowstate.setting.theme;
  themePolarity = config.lib.stylix.polarity; #lib.removeSuffix "\n" (builtins.readFile (./. + "../../../../themes" + ("/" + theme) + "/polarity.txt"));
  dashboardLogo = ./. + "/nix-" + themePolarity + ".png";

in {
  options.flowstate.apps.doom-emacs = with types; {
    enable = mkBoolOpt false "Enable or disable Emacs";
  };

  config = mkIf cfg.enable {
    flowstate.apps.tools.python3 = enabled;

    environment.systemPackages = with pkgs; [ 
      emacs29-pgtk 

      #Needed for doom packages
      cmake
      gnumake
      libxml2
      discount
      black
      python311Packages.pyflakes
      python311Packages.isort
      python311Packages.pipenv
      python311Packages.pytest
      rustc
      cargo
      rust-analyzer
      shfmt
      shellcheck
      html-tidy
      stylelint
      jsbeautifier

      flameshot
    ];

    
  };
}
