{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.tools.gcc;
in {
  options.flowstate.apps.tools.gcc = with types; {
    enable = mkBoolOpt false "Enable gcc";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ gcc_multi ]; };
}
