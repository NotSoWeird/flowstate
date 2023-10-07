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
    flowstate.home.programs = {
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
        # enableSyntaxHighlightning = true;
      };
    };

    flowstate.home.file.".zshrc".source = ./.zshrc;
  };
}
