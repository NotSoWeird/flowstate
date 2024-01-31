{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.tools.libreoffice;
in {
  options.flowstate.apps.tools.libreoffice = with types; {
    enable = mkBoolOpt false "Enable or disable libreoffice";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ libreoffice-fresh ];
  };
}
