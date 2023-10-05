{ config, lib, pkgs, ... }:

# https://github.com/HeinzDev/Hyprland-dotfiles/blob/9a729b79e83f71c291063ca82b5092075815d021/home/scripts/default.nix

let
  cava-internal = pkgs.writeShellScriptBin "cava-internal" ''
    cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
  '';
  cool-retro-term-zsh = pkgs.writeShellScriptBin "cool-retro-term-zsh" ''
    cool-retro-term -e zsh
  '';
    rofiWindow = pkgs.writeShellScriptBin "rofiWindow" ''
#!/usr/bin/env bash
## Run
rofi \
    -show drun \
    -theme "$HOME/.config/rofi/theme.rasi"
  '';
  wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" ''
    if command -v swww >/dev/null 2>&1; then 
        killall dynamic_wallpaper
        swww img $(find ~/Pictures/wallpapers/. -name "*.png" | shuf -n1) --transition-type simple
    fi
  '';
  default_wall = pkgs.writeShellScriptBin "default_wall" ''
    if command -v swww >/dev/null 2>&1; then 
          swww img ~/Pictures/wallpapers/menhera.jpg  --transition-type simple
    fi
  '';
in
{
  home.packages = with pkgs; [
    cool-retro-term-zsh
    rofiWindow
    cava-internal
    wallpaper_random
    default_wall
  ];
}
