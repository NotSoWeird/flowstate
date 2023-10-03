{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.suites.desktop;
in
{
  options.flowstate.suites.desktop = with types; {
    enable = mkBoolOpt false "Enable the desktop suite";
  };

  config = mkIf cfg.enable {
    flowstate = {
      desktop.hyprland.enable = true;
      apps = {
        firefox = enabled;
        tools.gnupg = enabled;
      };
    };
    
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
