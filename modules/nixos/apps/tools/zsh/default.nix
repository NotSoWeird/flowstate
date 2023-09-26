{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.apps.tools.zsh;
in
{
  options.apps.tools.zsh = with types; {
    enable = mkBoolOpt false "Enable zsh";
  };

  config = mkIf cfg.enable {
    home.programs = {
      zsh = {
        oh-my-zsh = {
          enable = true;
          theme = "refined";
          plugins = [
            "git"
          ];
        };

        enableAutosuggestions = true;
        enableCompletion = true;
        enableSyntaxHighlightning = true;
      };
    };

    home.file.".zshrc".text = ''
      export PATH=$HOME/bin:/usr/local/bin:$PATH
      # Path to your oh-my-zsh installation.
      #export ZSH="$HOME/.oh-my-zsh"

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


      ZSH_THEME="refined"
      REFINED_CHAR_SYMBOL="⚡"

      # Rofi
      export PATH=$HOME/.config/rofi/scripts:$PATH
    '';
  };
}
