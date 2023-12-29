{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktops.addons.swww;
in {
  options.flowstate.desktops.addons.swww = with types; {
    enable = mkBoolOpt false "Enable or disable SWWW";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swww
      (writeShellScriptBin "wallpaper_random" ''
        if command -v swww >/dev/null 2>&1; then
            killall dynamic_wallpaper
            swww img $(find ~/Pictures/wallpapers/. -name "*.png" | shuf -n1) --transition-type simple
        fi
      '')
    ];
  };
}
