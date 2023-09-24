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
    nixcfg = enabled;

    hardware = {
      audio = enabled;
      networking = enabled;
      storage = enabled;
    };

    system = {
      boot = enabled;
      fonts = enabled;
      locale = enabled;
      time = enabled;
      xkb = enabled;
    };

    cli-apps = {
      helix = enabled;
    };

    tools = {
      git = enabled;
      misc = enabled;
    };
  };
}
