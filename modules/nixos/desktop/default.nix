{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktop;
in
{
  options.flowstate.desktop = with types; {
    enable = mkBoolOpt false "Enable or disable some configs for desktop.";
  };

  config = mkIf cfg.enable {
    flowstate.home.configFile."theme/" = {
      source = ./themes/catppuccin-mocha;
      recursive = true;
    };

    environment.variables = {
      GTK_THEME = "Catppuccin-Mocha-Compact-Blue-dark";
    };

    flowstate.home.extraOptions.gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Compact-Blue-dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "blue" ];
          size = "compact";
          variant = "mocha";
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
