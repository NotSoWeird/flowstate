{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.addons.rofi;
in
{
  options.flowstate.desktops.addons.rofi = with types; {
    enable = mkBoolOpt false "Enable or disable the rofi run launcher.";
  };

  config = mkIf cfg.enable {
    home.programs.rofi = {
      enable = true;
      terminal = "${pkgs.cool-retro-term}/bin/cool-retro-term";
      theme = ./theme.rasi;
    };

    flowstate = {
      home.configFile.".config/rofi/theme.rasi".source = ./theme.rasi;
      home.configFile.".config/rofi/colors/dracula.rasi".source = ./colors/dracula.rasi;
      home.configFile.".config/rofi/colors/catppuccin.rasi".source = ./colors/catppuccin.rasi;
    };
  };
}
