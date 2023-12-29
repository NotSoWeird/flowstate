{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.suites.laptop;
in {
  options.flowstate.suites.laptop = with types; {
    enable = mkBoolOpt false "whether or not to enable the laptop configuration.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      system = {
        boot = enabled;
        env = enabled;
        fonts = enabled;
        locale = enabled;
        nix = enabled;
        printing = enabled;
        time = enabled;
        xkb = enabled;
      };

      hardware = {
        audio = enabled;
        bluetooth = enabled;
        networking = enabled;
        power = enabled;
      };
    };

    environment.systemPackages = with pkgs.flowstate; [
      wallpapers
    ];
  };
}
