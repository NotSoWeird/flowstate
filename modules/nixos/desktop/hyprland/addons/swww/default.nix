{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland.addons.swww;
in {
  options.flowstate.desktop.hyprland.addons.swww = with types; {
    enable = mkBoolOpt false "Enable or disable SWWW";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swww
    ];
  };
}
