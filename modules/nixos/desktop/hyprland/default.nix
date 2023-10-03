{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktop.hyprland;
in
{
  options.flowstate.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    # Desktop additions
    flowstate.desktop.addons = {
      waybar.enable = true;
      swww.enable = true;
      wofi.enable = true;
      mako.enable = true;
      gtklock.enable = true;
    };

    apps.kitty.enable = true;

    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;

    environment.systemPackages = with pkgs; [
      grim
      slurp
      swappy
      imagemagick

      (writeShellScriptBin "screenshot" ''
        grim -g "$(slurp)" - | convert - -shave 1x1 PNG:- | wl-copy
      '')
      (writeShellScriptBin "screenshot-edit" ''
        wl-paste | swappy -f -
      '')
    ];

    # Hyprland configuration files
    flowstate = {
      home.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
      home.configFile."hypr/launch".source = ./launch;
    };
  };
}
