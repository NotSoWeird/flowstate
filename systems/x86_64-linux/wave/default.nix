{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [./hardware.nix];

  nixpkgs.config.allowUnfree = true;

  flowstate = {
    suites.hyprV2.enable = true;
  };
  system.stateVersion = "23.05";
}
