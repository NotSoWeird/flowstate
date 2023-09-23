{ options, config, lib, pkgs, ... }:

with lib;
let
    cfg = config.tools.git;
    user = config.user;
in
{
    options.tools.git = with types; {
        enable = mkBoolOpt false "Whether or not to install and configure git.";
        userName = mkOpt types.str user.fullName "The name to configure git with";
        userEmail = mkOpt types.str user.email "The email to configure git with";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            git
        ];

        home.extraOptions = {
            programs.git = {
                enable = true;
                inherit (cfg) userName userEmail;
                lfs = enabled;

                extraConfig = {
                    init = { defaultBranch = "main"; };
                    pull = { rebase = true; };
                    push = { autoSetupRemote = true; };
                    core = { whitespace = "trailing-space,space-before-tab"; };
                    safe = {
                        directory = "${config.users.users.${user.name}.home}/work/config";
                    };
                };
            };
        };
    };
}