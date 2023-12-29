{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [./hardware.nix];

  flowstate = {suites.hyprV2.enable = true;};
  system.stateVersion = "23.05";
}
