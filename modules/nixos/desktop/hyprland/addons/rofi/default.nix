{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland.addons.rofi;
in {
  options.flowstate.desktop.hyprland.addons.rofi = with types; {
    enable = mkBoolOpt false "Enable or disable the rofi run launcher.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      home = {
        programs.rofi = {
          enable = true;
          terminal = "kitty";
          theme = ./theme.rasi;
        };

        configFile."rofi/theme.rasi".source = ./theme.rasi;
        configFile."rofi/colors.rasi".text = ''
          * {
               background:     #'' + config.lib.stylix.colors.base00 + ''
            FF;
               background-alt: #'' + config.lib.stylix.colors.base01 + ''
              FF;
                 foreground:     #'' + config.lib.stylix.colors.base05 + ''
                FF;
                   selected:       #'' + config.lib.stylix.colors.base08 + ''
                  FF;
                     active:         #'' + config.lib.stylix.colors.base04 + ''
                    FF;
                       urgent:         #'' + config.lib.stylix.colors.base05
          + ''
            FF;
            }
          '';
      };
    };
  };
}
