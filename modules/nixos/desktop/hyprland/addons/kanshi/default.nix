{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland.addons.kanshi;
in {
  options.flowstate.desktop.hyprland.addons.kanshi = with types; {
    enable = mkBoolOpt false "Enable or disable kanshi.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      swaylock-effects
    ];
    flowstate = {
      home.services.kanshi = {
        enable = true;
        systemdTarget = "hyprland-session.target";

        profiles = {
          undocked = {
            outputs = [
              {
                criteria = "eDP-1";
                mode = "3840x2160@60";
                scale = 2;
                status = "enable";
              }
            ];
          };

          home_office = {
            outputs = [
              {
              criteria = "BNQ BenQ XL2420G J3F00752SL0";
              position = "3840,0";
              mode = "1920x1080@144Hz";
              }
              {
                criteria = "AOC U2777B 0x00000048";
                position = "0,0";
                mode = "3840x2160@60Hz";
              }
              {
                criteria = "eDP-1";
                status = "disable";
              }
            ];
          };
    };
  };

    };
    
  };
}
