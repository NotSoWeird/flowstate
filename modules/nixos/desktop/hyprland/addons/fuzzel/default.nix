{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland.addons.fuzzel;
in {
  options.flowstate.desktop.hyprland.addons.fuzzel = with types; {
    enable = mkBoolOpt false "Enable or disable fuzzel";
  };

  config = mkIf cfg.enable {
    flowstate.home.programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = lib.flowstate.setting.font + ":size=13";
          terminal = "${pkgs.alacritty}/bin/alacritty";
        };
        colors = {
          background = config.lib.stylix.colors.base00 + "e6";
          text = config.lib.stylix.colors.base07 + "ff";
          match = config.lib.stylix.colors.base05 + "ff";
          selection = config.lib.stylix.colors.base08 + "ff";
          selection-text = config.lib.stylix.colors.base00 + "ff";
          selection-match = config.lib.stylix.colors.base05 + "ff";
          border = config.lib.stylix.colors.base08 + "ff";
        };
        border = {
          width = 3;
          radius = 7;
        };
      };
    };
  };
}
