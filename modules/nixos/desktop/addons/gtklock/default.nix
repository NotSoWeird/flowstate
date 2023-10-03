{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktop.addons.gtklock;
in
{
  options.flowstate.desktop.addons.gtklock = with types; {
    enable = mkBoolOpt false "Enable or disable the gtklock screen locker.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gtklock
    ];
    security.pam.services.gtklock = { };

    flowstate.home.configFile."gtklock/style.css".source = ./style.css;
  };
}
