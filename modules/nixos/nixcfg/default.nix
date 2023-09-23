{ options, config, pkgs, lib, inputs, ... }:

with lib;
let
  cfg = config.nixcfg;
in
{
  options.nixcfg = with types; {
    enable = mkBoolOpt false "Whether or not to manage nix configuration.";
  };

  config = mkIf cfg.enable {
    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        warn-dirty = false;
        sandbox = "relaxed";
        auto-optimise-store = true;
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };

      # flake-utils-plus
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };
}
