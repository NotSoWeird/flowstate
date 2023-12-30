{ config, lib, pkgs, ... }:
let
  cool-retro-term-zsh = pkgs.writeShellScriptBin "cool-retro-term-zsh" ''
    cool-retro-term -e zsh
  '';
  wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" ''
    if command -v swww >/dev/null 2>&1; then
        swww img $(find ~/Pictures/wallpapers/. -regex '.*\(.png\|.jpg\)$'  | shuf -n1) --transition-type random
    fi
  '';
in {
  home.packages = with pkgs; [
    cool-retro-term-zsh
    wallpaper_random
  ];
}
