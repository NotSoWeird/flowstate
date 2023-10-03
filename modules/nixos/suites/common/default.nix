{ options, config, lib, pkgs, ... }:

with lib;
with lib.flowstate;
let
  cfg = config.flowstate.suites.common;
in
{
  options.flowstate.suites.common = with types; {
    enable = mkBoolOpt false "whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    nix = enabled;

    hardware = {
      audio = enabled;
      networking = enabled;
    };

    system = {
      boot = enabled;
      fonts = enabled;
      locale = enabled;
      time = enabled;
      xkb = enabled;
    };

    apps = {
      helix = enabled;
      misc = enabled;
      tools = {
        git = enabled;
      };
    };

  };
}
