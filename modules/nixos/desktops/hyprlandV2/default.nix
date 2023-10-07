{ options, config, lib, pkgs, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktops.hyprlandV2;
in
{
  options.flowstate.desktops.hyprlandV2 = with types; {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      apps.kitty = enabled;

      desktops.hyprlandV2.addons = {
        dunst = enabled;
        gtk3 = enabled;
        kvantum = enabled;
        mangohud = disabled;
        nwg-look = enabled;
        qt5ct = enabled;
        rofi = enabled;
        swaylock = enabled;
        swww = enabled;
        wallpapers = enabled;
        waybar = enabled;
        wlogout = enabled;
        xsettingsd = enabled;
      };
    };

    flowstate = {
      home.configFile."hypr/" = {
        source = ./hypr;
        recursive = true;
      };
      home.configFile."kdeglobals".source = ./kdeglobals;
    }; 
  };
}
