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
      libsForQt5.dolphin
    ];

    flowstate.home.configFile."dolphinrc".source = ./dolphinrc;
    flowstate.home.file.".local/share/dolphin/" = {
      source = ./dolphin;
      recursive = true;
    };
    flowstate.home.file.".local/share/kxmlgui5/" = {
      source = ./kxmlgui5;
      recursive = true;
    };
  };
}
