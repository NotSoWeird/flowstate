{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.suites.common;
in
{
  options.suites.common = with types; {
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
