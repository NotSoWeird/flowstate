{ config, lib, pkgs, inputs, ... }:
with lib;
with lib.flowstate;
let
  cfg = config.flowstate.apps.editor.doom-emacs;
  theme = lib.flowstate.setting.theme;
  themePolarity =
    config.lib.stylix.polarity; # lib.removeSuffix "\n" (builtins.readFile (./. + "../../../../themes" + ("/" + theme) + "/polarity.txt"));
  dashboardLogo = ./. + "/nix-" + themePolarity + ".png";

in {
  options.flowstate.apps.editor.doom-emacs = with types; {
    enable = mkBoolOpt false "Enable or disable Emacs";
  };

  config = mkIf cfg.enable {
    flowstate.apps = {
      tools.python3 = enabled;
      cli.treesitter = enabled;
    };

    flowstate.home.programs = {
      emacs = {
        enable = true;
        package = pkgs.emacs29-pgtk;
        extraPackages = epkgs:
          with epkgs; [
            # include Doom Emacs dependencies that tries to build native C code
            emacsql
            emacsql-sqlite
            pdf-tools
            vterm
            treesit-grammars.with-all-grammarr
          ];
      };
    };

    environment.systemPackages = with pkgs; [
      #emacs29-pgtk

      #Needed for doom packages
      cmake
      gnumake
      libxml2
      discount
      black
      python311Packages.pyflakes
      python311Packages.isort
      pipenv
      python311Packages.pytest
      rustc
      cargo
      sqlite
      rust-analyzer
      shfmt
      shellcheck
      html-tidy
      stylelint
      jsbeautifier
      jdk
      flameshot
      nil
      libclang
      graphviz
      mermaid-cli
      hunspell
      hunspellDicts.sv_SE
      hunspellDicts.en_US
      languagetool
      ccls
      zathura
      pandoc
    ];

    flowstate.home.configFile."doom/" = {
      source = ./doom;
      recursive = true;
    };
  };
}
