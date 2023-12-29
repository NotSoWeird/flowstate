{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.hardware.power;
in {
  options.flowstate.hardware.power = with types; {
    enable = mkBoolOpt false "Whether or not to enable power management.";
  };

  config = mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;
      };
    };
  };
}
