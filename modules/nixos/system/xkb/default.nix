{ options, config, lib, pkgs, ... }:

with lib;
with lib.flowstate;
let
  cfg = config.flowstate.system.xkb;
in
{
  options.flowstate.system.xkb = with types; {
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
