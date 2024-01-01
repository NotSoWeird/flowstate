{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland.addons.fnott;
in {
  options.flowstate.desktop.hyprland.addons.fnott = with types; {
    enable = mkBoolOpt false "Enable or disable SWWW";
  };

  config = mkIf cfg.enable {
    flowstate.home.extraOptions.services.fnott = {
      enable = true;
      settings = {
        main = {
          anchor = "bottom-right";
          stacking-order = "top-down";
          min-width = 400;
          title-font = lib.flowstate.setting.font + ":size=14";
          summary-font = lib.flowstate.setting.font + ":size=12";
          body-font = lib.flowstate.setting.font + ":size=11";
          border-size = 0;
        };
        low = {
          background = config.lib.stylix.colors.base00 + "e6";
          title-color = config.lib.stylix.colors.base03 + "ff";
          summary-color = config.lib.stylix.colors.base03 + "ff";
          body-color = config.lib.stylix.colors.base03 + "ff";
          idle-timeout = 150;
          max-timeout = 30;
          default-timeout = 8;
        };
        normal = {
          background = config.lib.stylix.colors.base00 + "e6";
          title-color = config.lib.stylix.colors.base07 + "ff";
          summary-color = config.lib.stylix.colors.base07 + "ff";
          body-color = config.lib.stylix.colors.base07 + "ff";
          idle-timeout = 150;
          max-timeout = 30;
          default-timeout = 8;
        };
        critical = {
          background = config.lib.stylix.colors.base00 + "e6";
          title-color = config.lib.stylix.colors.base08 + "ff";
          summary-color = config.lib.stylix.colors.base08 + "ff";
          body-color = config.lib.stylix.colors.base08 + "ff";
          idle-timeout = 0;
          max-timeout = 0;
          default-timeout = 0;
        };
      };
    };
  };
}
