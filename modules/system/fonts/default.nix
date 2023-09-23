{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.system.fonts;
in
{
  options.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    fonts = {
      fonts.fontDir.enable = true;

      fonts = with pkgs; [
        nerdfonts
        google-fonts
      ] ++ cfg.fonts;
    };
  };
}
