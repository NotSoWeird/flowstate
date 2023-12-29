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
  cfg = config.flowstate.stylix;
  theme = "uwunicorn";
  themePath = "../../../../themes" + ("/" + theme + "/" + theme) + ".yaml";
  themePolarity =
    lib.removeSuffix "\n" (builtins.readFile
      (./. + "../../../../themes" + ("/" + theme) + "/polarity.txt"));
  backgroundUrl =
    builtins.readFile
    (./. + "../../../../themes" + ("/" + theme) + "/backgroundurl.txt");
  backgroundSha256 =
    builtins.readFile
    (./. + "../../../../themes/" + ("/" + theme) + "/backgroundsha256.txt");
in {
  options.flowstate.stylix = with types; {
    enable = mkBoolOpt false "Enable Stylix";
  };

  config = mkIf cfg.enable {
    flowstate.home.file.".currenttheme".text = theme;
    lib.stylix = {
      polarity = themePolarity;

      image = pkgs.fetchurl {
        url = backgroundUrl;
        sha256 = backgroundSha256;
      };
      base16Scheme = ./. + themePath;

      fonts = {
        serif = {
          package = pkgs.nerdfonts;
          name = "FiraCode Nerd Font Mono";
        };
        sansSerif = {
          package = pkgs.nerdfonts;
          name = "FiraCode Nerd Font Mono";
        };
        monospace = {
          package = pkgs.nerdfonts;
          name = "FiraCode Nerd Font Mono";
        };
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-emoji-blob-bin;
        };
        sizes = {
          desktop = 12;
          applications = 15;
          terminal = 15;
          popups = 12;
        };
      };
      opacity = {
        terminal = 0.90;
        applications = 0.90;
        popups = 0.50;
        desktop = 0.90;
      };
      targets = {
        console.enable = true;
        waybar.enableLeftBackColors = true;
        waybar.enableRightBackColors = true;
      };
    };
  };
}
