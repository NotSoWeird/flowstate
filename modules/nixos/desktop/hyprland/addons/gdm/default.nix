{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktop.hyprland.addons.gdm;
in {
  options.flowstate.desktop.hyprland.addons.gdm = with types; {
    enable = mkBoolOpt false "Whether or not to enable gdm display manager";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };
}
