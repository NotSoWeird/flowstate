{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.keepassxc;
in {
  options.flowstate.apps.tools.keepassxc = with types; {
    enable = mkBoolOpt false "Enable keepassxc";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      keepassxc
    ];

    flowstate.home.configFile."keepassxc/keepassxc.ini".source = ./keepassxc.ini;
  };
}
