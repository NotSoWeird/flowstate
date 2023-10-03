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

    environment.systemPackages = with pkgs; [
      bibata-cursors
      dunst
      librewolf
      gnome.nautilus
      wofi
      pamixer
      slurp
      cool-retro-term
    ];

    apps.kitty.enable = true;

    desktops.addons = {
      waybar = enabled;
      rofi = enabled;
      scripts = enabled;
    };

    flowstate.desktops.addons.wallpapers = enabled;
    
    programs.regreet = enabled;
    programs.dconf = enabled;
    programs.hyprland = enabled;
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          user = config.user.name;
          command = "$SHELL -l";
        };
      };
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };

    home.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    home.configFile."hypr/launch".source = ./launch;
    home.configFile."hypr/colors".source = ./colors;
  };
}
