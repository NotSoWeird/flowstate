{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktops.hyprlandV2.addons.swww;
in {
  options.flowstate.desktops.hyprlandV2.addons.swww = with types; {
    enable = mkBoolOpt false "Enable or disable SWWW";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swww
      (writeShellScriptBin "wallpaper_random" ''
        if command -v swww >/dev/null 2>&1; then
            swww img $(find ~/Pictures/wallpapers/. -regex '.*\(.png\|.jpg\)$'  | shuf -n1) --transition-type random
        fi
      '')
    ];
  };
}
