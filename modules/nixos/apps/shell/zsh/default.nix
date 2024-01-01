{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.shell.zsh;
in {
  options.flowstate.apps.shell.zsh = with types; {enable = mkBoolOpt false "Enable zsh";};

  config = mkIf cfg.enable {
    flowstate.apps.cli = {
      fastfetch = enabled;
      krabby = enabled;
      onefetch = enabled;
      starship = enabled;
    };

    programs.zsh.ohMyZsh.enable = true;

    flowstate.home.programs = {
      zsh = {
        enable = true;
        oh-my-zsh = {enable = true;};

        shellAliases = {
          l = "eza -l --icons";
          ls = "eza -1 --icons";
          ll = "eza -la --icons";
          ld = "eza -lD --icons";
          pokemon = "krabby random";
          vc = "code";
          c = "clear";
          clr = "clear";
          ff = "fastfetch";
          of = "onefetch";
          cff = "clear 
                fastfetch";
          mkenv = "nix flake new -t github:nix-community/nix-direnv .
          direnv allow";
          wallpaper_random = "swww img $(find ~/Pictures/wallpapers/. -regex '.*\(.png\|.jpg\)$'  | shuf -n1) --transition-type random";
          doom = "~/.config/emacs/bin/doom";
        };

        enableAutosuggestions = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
      };
    };

    flowstate.home.file.".zshrc".text = ''
      CASE_SENSITIVE="true"

      krabby random

      eval "$(direnv hook zsh)"
    '';
  };
}
