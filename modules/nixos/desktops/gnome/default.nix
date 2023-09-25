{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.desktops.gnome;
in
{
  options.desktops.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to enable Gnome.";
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;

        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };
  };
}