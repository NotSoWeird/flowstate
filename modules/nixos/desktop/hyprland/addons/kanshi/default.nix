{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland.addons.kanshi;
in {
  options.flowstate.desktop.hyprland.addons.kanshi = with types; {
    enable = mkBoolOpt false "Enable or disable SWWW";
  };

  config = mkIf cfg.enable {
    flowstate.home.extraOptions.services.kanshi = {
      enable = true;
      systemdTarget = "hyprland-session.target";

      profiles = {
        undocked = {
          outputs = [{
            criteria = "eDP-1";
            scale = 2.0;
            status = "enable";
          }];
        };

        docked = {
          outputs = [
            {
              criteria = "DP-3";
              position = "3840,0";
              mode = "1920x1080@144";
            }
            {
              criteria = "DP-5";
              position = "0,0";
              mode = "3840x2160@60";
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
}
