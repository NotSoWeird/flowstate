{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.addons.cool-retro-term;
in {
  options.flowstate.desktops.addons.cool-retro-term = with types; {
    enable = mkBoolOpt false "Enable or disable cool-retro-term";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cool-retro-term
      (writeShellScriptBin "cool-retro-term-zsh" ''
        cool-retro-term -e zsh
      '')
    ];
  };
}
