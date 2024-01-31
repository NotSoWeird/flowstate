{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.chat.teams;
in {
  options.flowstate.apps.chat.teams = with types; {
    enable = mkBoolOpt false "Enable or disable Teams";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ teams-for-linux ];
  };
}
