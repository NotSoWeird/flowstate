{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.terminal.foot;
in {
  options.flowstate.apps.terminal.foot = with types; {
    enable = mkBoolOpt false "Enable or disable the foot terminal.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      foot
    ];

    flowstate.home.configFile."foot/foot.ini".source = ./foot.ini;
  };
}
