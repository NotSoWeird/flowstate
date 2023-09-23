{ options, config, lib, pkgs, ... }:

with lib;
let
    cfg = config.tools.misc;
in
{
    options.tools.misc = with types; {
        enable = mkBoolOpt false "Whether or not to enable common utilities.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            fzf
            unzip
            file
            clac
            wget
            fastfetch
        ];
    };
}