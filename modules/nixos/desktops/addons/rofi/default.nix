{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktops.addons.rofi;
in {
  options.flowstate.desktops.addons.rofi = with types; {
    enable = mkBoolOpt false "Enable or disable the rofi run launcher.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      home = {
        programs.rofi = {
          enable = true;
          terminal = "${pkgs.cool-retro-term}/bin/cool-retro-term";
          theme = ./theme.rasi;
        };

        configFile."rofi/theme.rasi".source = ./theme.rasi;
        configFile."rofi/colors/dracula.rasi".source = ./colors/dracula.rasi;
        configFile."rofi/colors/catppuccin.rasi".source =
          ./colors/catppuccin.rasi;
      };
    };
  };
}
