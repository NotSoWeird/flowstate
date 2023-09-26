{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.suites.desktop;
in
{
  options.suites.desktop = with types; {
    enable = mkBoolOpt false "Enable the desktop suite";
  };

  config = mkIf cfg.enable {
    desktop.hyprland.enable = true;
    apps.firefox.enable = true;

    apps.tools.gnupg.enable = true;

    services = {
      flatpak.enable = true;

      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      cinnamon.nemo
      xclip
      xarchiver
    ];

  };
}
