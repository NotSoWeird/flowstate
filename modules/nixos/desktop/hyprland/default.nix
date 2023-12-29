{ options, config, lib, pkgs, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland;
in {
  options.flowstate.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      desktop.hyprland.addons = {
        dunst = enabled;
      };
    };

    flowstate = {
      home.configFile."hypr/" = {
        source = ./hypr;
        recursive = true;
      };
    };
  };
}
