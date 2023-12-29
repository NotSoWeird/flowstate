{ options, config, lib, pkgs, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktops.hyprlandV2;
in {
  options.flowstate.desktops.hyprlandV2 = with types; {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    flowstate = {
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
      apps = {
        terminal.kitty = enabled;
        cli.krabby = enabled;
        tools = {
          dolphin = enabled;
          starship = enabled;
          zsh = enabled;
        };
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
