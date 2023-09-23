{ options, config, lib, pkgs, ... }:

with lib;
let
    cfg = config.hardware.networking;
in
{
    options.hardware.networking = with types; {
        enable = mkBoolOpt false "Whether or not to enable networking support";
        hosts = mkOpt attrs { }
            (mdDoc "An attribute set to merge with 'networking.hosts'");
    };

    config = mkIf cfg.enable {
        user.extraGroups = [ "networkmanager" ];

        networking = {
            hostName = "nixflow";
            wireless.enable = true;
            networkmanager.enable = true;
        }

    };

        # Fixes an issue that normally causes nixos-rebuild to fail.
        # https://github.com/NixOS/nixpkgs/issues/180175
        systemd.services.NetworkManager-wait-online.enable = false;
    };
}