{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.browser.qutebrowser;
in {
  options.flowstate.apps.browser.qutebrowser = with types; {
    enable = mkBoolOpt false "Enable or disable qutebrowser";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ qutebrowser ];
  };
}
