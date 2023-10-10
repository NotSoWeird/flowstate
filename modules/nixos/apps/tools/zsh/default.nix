{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.zsh;
in
{
  options.flowstate.apps.tools.zsh = with types; {
    enable = mkBoolOpt false "Enable zsh";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      zsh-powerlevel10k
      meslo-lgs-nf
    ];

    programs.zsh.ohMyZsh.enable = true;
    
    flowstate.home.programs = {
      zsh = {
        enable = true;
        oh-my-zsh = {
          enable = true;
          theme = "powerlevel10k";
          plugins = [
            "git"
            "zsh-syntax-highlighting"
            "zsh-autosuggestions"
          ];
        };

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
          cff = "clear \
                fastfetch
                ";
        };

        # enableAutosuggestions = true;
        # enableCompletion = true;
        # enableSyntaxHighlightning = true;
      };
    };

    flowstate.home.file.".zshrc".text = ''
      CASE_SENSITIVE="true"

      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      krabby random
    '';
  };
}
