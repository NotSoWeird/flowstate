{ options, config, pkgs, lib, ... }:
with lib;
with lib.flowstate;
let
  cfg = config.desktops.addons.wallpapers;
  inherit (pkgs) wallpapers;
in
{
  options.desktops.addons.wallpapers = with types; {
    enable = mkBoolOpt false "Add wallpapers to ~/Pictures/wallpapers.";
  };

  config = mkIf cfg.enable {
    home.file = lib.foldl
      (acc: name:
        let wallpaper = wallpapers.${name};
        in
        acc // {
          "Pictures/wallpapers/${wallpaper.fileName}".source = wallpaper;
        })
      { }
      (wallpapers.names);
  };
}
