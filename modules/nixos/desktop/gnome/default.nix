{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.system.xkb;
in {
  options.flowstate.system.xkb = with types; {
    enable = mkBoolOpt false "Whether or not to enable Gnome";
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;
  };
}
