{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.system.fonts;
in
{
  options.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [
      font-manager
    ];

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ] ++ cfg.fonts;
  };
}
