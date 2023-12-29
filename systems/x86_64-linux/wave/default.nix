{ pkgs, lib, ... }:
with lib; {
  imports = [ ./hardware.nix ];

  flowstate.suites.laptop.enable = true;
  system.stateVersion = "23.05";
}
