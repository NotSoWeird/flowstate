{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.tools.blender;
in {
  options.flowstate.apps.tools.blender = with types; {
    enable = mkBoolOpt false "Enable blender";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ blender ]; };
}
