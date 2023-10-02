{ options, config, lib, pkgs, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.desktops.hyprland;
in
{
  options.desktops.hyprland = with types; {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    programs.regreet.enable = true;
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          user = config.user.name;
          command = "$SHELL -l";
        };
      };
    };

    programs.dconf.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };



    programs.hyprland.enable = true;
    
    home.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    home.configFile."hypr/launch".source = ./launch;
    home.configFile."hypr/colors".source = ./colors;
  };
}
