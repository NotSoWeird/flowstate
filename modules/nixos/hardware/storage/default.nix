{ options, config, lib, pkgs, ... }:

with lib;
let
    cfg = config.hardware.storage;
in
{
    options.hardware.storage = with types; {
        enable = mkBoolOpt false "Whether or not to enable support for storage devices.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            ntfs3g
            fuseiso
        ];
    };
}