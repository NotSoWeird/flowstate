{ options, config, pkgs, lib, ... }:
with lib;
with lib.flowstate;
let
  cfg = config.desktops.addons.scripts;
  inherit (pkgs) scripts;
in
{
  options.desktops.addons.scripts = with types; {
    enable = mkBoolOpt false "Enable hyprland scripts";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "cava-internal" ''
        cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
      '')
      (writeShellScriptBin "cool-retro-term-zsh" ''
        cool-retro-term -e zsh
      '')
      (writeShellScriptBin "rofi1" ''
        ~/.config/rofi/launchers/type-1/launcher.sh
      '')
      (writeShellScriptBin "rofi2" ''
        ~/.config/rofi/launchers/type-2/launcher.sh
      '')
      (writeShellScriptBin "rofiWindow" ''
        #!/usr/bin/env bash
        ## Run
        rofi \
            -show drun \
            -theme "$HOME/.config/rofi/theme.rasi"
      '')
      (writeShellScriptBin "wallpaper_random" ''
        if command -v swww >/dev/null 2>&1; then 
            killall dynamic_wallpaper
            swww img $(find ~/Pictures/wallpapers/. -name "*.png" | shuf -n1) --transition-type simple
        fi
      '')
      (writeShellScriptBin "default_wall" ''
        if command -v swww >/dev/null 2>&1; then 
              swww img ~/Imagens/wallpapers/menhera.jpg  --transition-type simple
        fi
      '')
    ];
  };
}
