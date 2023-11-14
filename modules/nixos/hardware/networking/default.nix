{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.hardware.networking;
in {
  options.flowstate.hardware.networking = with types; {
    enable = mkBoolOpt false "Whether or not to enable networking support";
    hosts =
      mkOpt attrs {}
      (mdDoc "An attribute set to merge with 'networking.hosts'");
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;

    # Fixes an issue that normally causes nixos-rebuild to fail.
    # https://github.com/NixOS/nixpkgs/issues/180175
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
