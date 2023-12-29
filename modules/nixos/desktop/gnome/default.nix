{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.gnome;
in {
  options.flowstate.desktop.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to enable Gnome";
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;
  };
}
