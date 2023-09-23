{ options, config, lib, pkgs, ... }:

with lib;
let
    cfg = config.tools.comma;
in
{
    options.tools.comma = with types; {
        enable = mkBoolOpt false "Whether or not to enable comma.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            comma
            nix-update-index
        ];

        home = {
            configFile = {
                "wgetrc".text = "";
            };

            extraOptions = {
                programs.nix-index-enable = true;
            };
        };
    };
}