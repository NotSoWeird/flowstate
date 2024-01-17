{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.terminal.xfce4-terminal;
in {
  options.flowstate.apps.terminal.xfce4-terminal = with types; {
    enable = mkBoolOpt false "Enable or disable the xfce4-terminal.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ xfce4-terminal ];
  };
}
