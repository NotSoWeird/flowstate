{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.suites.desktop;
in
{
  options.flowstate.suites.desktop = with types; {
    enable = mkBoolOpt false "Enable the desktop suite";
  };

  config = mkIf cfg.enable {
    flowstate = {
      desktops = {
        hyprland = enabled;
      };

      apps = {
        tools = {
          nix-ld = enabled;
          direnv = enabled;
          starship = enabled;
          zsh = enabled;
        };
      };
    };
    environment.systemPackages = with pkgs; [
      flowstate.sys
      flowstate.wallpapers
      # flowstate.scripts
    ];
  };
}
