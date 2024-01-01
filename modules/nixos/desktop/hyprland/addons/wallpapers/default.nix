{ config, pkgs, lib, ... }:
with lib;
with lib.flowstate;
let
  cfg = config.flowstate.desktop.hyprland.addons.wallpapers;
  inherit (pkgs.flowstate) wallpapers;
in {
  options.flowstate.desktop.hyprland.addons.wallpapers = with types; {
    enable = mkBoolOpt false
      "Whether or not to add wallpapers to ~/Pictures/wallpapers.";
  };

  config = mkIf cfg.enable {
    flowstate.home.file = lib.foldl (acc: name:
      let wallpaper = wallpapers.${name};
      in acc // {
        "Pictures/wallpapers/${wallpaper.fileName}".source = wallpaper;
      }) { } (wallpapers.names);
  };
}
