{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.tools.qemu;
in {
  options.flowstate.apps.tools.qemu = with types; {
    enable = mkBoolOpt false "Enable Qemu";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ qemu ]; };
}
