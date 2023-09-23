{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.system.xkb;
in
{
  options.system.xkb = with types; {
    enable = mkBoolOpt false "Whether or not to configure xkb.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver = {
      layout = "se";
      xkbVariant = "";
    };
  };
}
