{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.suites.dev;
in
{
  options.suites.dev = with types; {
    enable = mkBoolOpt false "whether or not to enable dev configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nvim
    ];
  };
}