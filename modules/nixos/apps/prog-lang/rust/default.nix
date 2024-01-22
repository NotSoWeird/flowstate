{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.prog-lang.rust;
in {
  options.flowstate.apps.prog-lang.rust = with types; {
    enable = mkBoolOpt false "Enable or disable rust.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ rustc cargo ];
  };
}
