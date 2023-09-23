{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.system.boot;
in
{
  options.system.boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable booting.";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = false;

      timout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 5;
        theme =
          pkgs.fetchFromGitHub
          {
            owner = "semimqmo";
            repo = "sekiro_grub_theme";
            rev = "1affe05f7257b72b69404cfc0a60e88aa19f54a6";
            sha256 = "02gdihkd2w33qy86vs8g0pfljp919ah9c13cj4bh9fvvzm5zjfn1";
          }
          + "/Sekiro";
      };

    };
  };
}
