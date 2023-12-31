{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.tools.zsh;
in {
  options.flowstate.apps.tools.zsh = with types; {
    enable = mkBoolOpt false "Enable zsh";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zsh-powerlevel10k meslo-lgs-nf ];

    programs.zsh.ohMyZsh.enable = true;

    flowstate.home.programs = {
      zsh = {
        enable = true;
        oh-my-zsh = { enable = true; };

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
          cff = "clear \n                fastfetch\n                ";
          mkenv =
            "nix flake new -t github:nix-community/nix-direnv .\n                    direnv allow\n                    ";
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
