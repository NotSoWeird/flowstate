{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland.addons.dunst;
in {
  options.flowstate.desktop.hyprland.addons.dunst = with types; {
    enable = mkBoolOpt false "Enable or disable the dunst.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ dunst ];
    flowstate = {
      home = {
        services.dunst = {
         enable = true;
        };

        configFile."dunst/dunstrc".source = ./dunstrc;
        configFile."dunst/icons/" = {
          source = ./icons;
          recursive = true;
        };
      };
    };
  };
}
