{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.chat.slack;
in {
  options.flowstate.apps.chat.slack = with types; {
    enable = mkBoolOpt false "Enable or disable Slack";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ slack ]; };
}
