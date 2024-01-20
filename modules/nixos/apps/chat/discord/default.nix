{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.chat.discord;
in {
  options.flowstate.apps.chat.discord = with types; {
    enable = mkBoolOpt false "Enable or disable discord";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ discord ]; };
}
