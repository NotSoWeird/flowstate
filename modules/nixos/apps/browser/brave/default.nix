{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.browser.brave;
in {
  options.flowstate.apps.browser.brave = with types; {
    enable = mkBoolOpt false "Enable or disable brave browser";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ brave ]; };
}
