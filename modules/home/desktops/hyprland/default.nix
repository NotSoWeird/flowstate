{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.internal;
let
  cfg = config.desktops.hyprland;
in
{
  options.desktops.hyprland = {
    enable = mkEnableOption "pls";
  };

  config = mkIf cfg.enable {
    home = {
      sessionVariables = {
        EDITOR = "hx";
        BROWSER = "firefox";
        TERMINAL = "kitty";
        #GBM_BACKEND= "nvidia-drm";
        #__GLX_VENDOR_LIBRARY_NAME= "nvidia";
        #LIBVA_DRIVER_NAME= "nvidia"; # hardware acceleration
        __GL_VRR_ALLOWED = "1";
        WLR_NO_HARDWARE_CURSORS = "1";
        WLR_RENDERER_ALLOW_SOFTWARE = "1";
        CLUTTER_BACKEND = "wayland";
        WLR_RENDERER = "vulkan";

        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
      };
    };
  };
}