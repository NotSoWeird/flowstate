{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let
  cfg = config.flowstate.stylix;
  theme = lib.flowstate.setting.theme;
  themePath = "../../../../themes" + ("/" + theme + "/" + theme) + ".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile
    (./. + "../../../../themes" + ("/" + theme) + "/polarity.txt"));
  backgroundUrl = builtins.readFile
    (./. + "../../../../themes" + ("/" + theme) + "/backgroundurl.txt");
  backgroundSha256 = builtins.readFile
    (./. + "../../../../themes/" + ("/" + theme) + "/backgroundsha256.txt");
in {
  options.flowstate.stylix = with types; {
    enable = mkBoolOpt false "Enable Stylix";
  };

  config = mkIf cfg.enable {
    flowstate.home.file.".currenttheme".text = theme;
    lib.stylix = {
      autoEnable = false;
      polarity = themePolarity;

      image = pkgs.fetchurl {
        url = backgroundUrl;
        sha256 = backgroundSha256;
      };
      base16Scheme = ./. + themePath;

      colors =
        { # currently set to uwunicorn need to find a way to set this automatically
          base00 = "241b26";
          base01 = "2f2a3f";
          base02 = "46354a";
          base03 = "6c3cb2";
          base04 = "7e5f83";
          base05 = "eed5d9";
          base06 = "d9c2c6";
          base07 = "e4ccd0";
          base08 = "877bb6";
          base09 = "de5b44";
          base0A = "a84a73";
          base0B = "c965bf";
          base0C = "9c5fce";
          base0D = "6a9eb5";
          base0E = "78a38f";
          base0F = "a3a079";
        };

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
        terminal = 0.9;
        applications = 0.9;
        popups = 0.5;
        desktop = 0.9;
      };
      targets = {
        console.enable = true;
        waybar.enableLeftBackColors = true;
        waybar.enableRightBackColors = true;
      };
    };
  };
}
