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
    environment.systemPackages = with pkgs; [ emacs29-pgtk ];
  };
}
