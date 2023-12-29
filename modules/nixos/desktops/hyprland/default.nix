{ options, config, lib, pkgs, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktops.hyprland;
in {
  options.flowstate.desktops.hyprland = with types; {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bibata-cursors
      dunst
      gnome.nautilus
      wofi
      pamixer
      slurp
    ];

    flowstate = {
      apps.terminal.kitty = enabled;

      desktops.addons = {
        cool-retro-term = enabled;
        waybar = enabled;
        rofi = enabled;
        swww = enabled;
        wallpapers = enabled;
      };
    };

    programs = {
      regreet = enabled;
      dconf = enabled;
      hyprland = enabled;
    };

    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          user = config.flowstate.user.name;
          command = "$SHELL -l";
        };
      };
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };

    flowstate = {
      home.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
      home.configFile."hypr/launch".source = ./launch;
      home.configFile."hypr/colors".source = ./colors;
    };
  };
}
