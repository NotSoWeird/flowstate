{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.system.fonts;
in {
  options.flowstate.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [
      font-manager
    ];

    fonts.fonts = with pkgs;
      [
        nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        twemoji-color-font
        fira-code
        fira-code-symbols
      ]
      ++ cfg.fonts;
  };
}
