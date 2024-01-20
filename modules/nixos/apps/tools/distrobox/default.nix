{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.tools.distrobox;
in {
  options.flowstate.apps.tools.distrobox = with types; {
    enable = mkBoolOpt false "Enable Distrobox";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ distrobox ];

    virtualisation.podman.enable = true;
  };
}
