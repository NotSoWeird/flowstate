{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.school.octave;
in {
  options.flowstate.apps.school.octave = with types; {
    enable = mkBoolOpt false "Enable or disable the octave.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      octaveFull
      octavePackages.signal
    ];
  };
}
