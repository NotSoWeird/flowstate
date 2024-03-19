{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.school.anki;
in {
  options.flowstate.apps.school.anki = with types; {
    enable = mkBoolOpt false "Enable or disable anki.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ anki ]; };
}
