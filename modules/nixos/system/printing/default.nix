{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.system.printing;
in {
  options.flowstate.system.printing = with types; {
    enable = mkBoolOpt false "Whether or not to enable printer support.";
  };

  config = mkIf cfg.enable {
    services = {
      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns = true;
        openFirewall = true;
      };
    };
    environment.systemPackages = [pkgs.cups-filters];
  };
}
