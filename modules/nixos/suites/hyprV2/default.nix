{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.suites.hyprV2;
in {
  options.flowstate.suites.hyprV2 = with types; {
    enable = mkBoolOpt false "whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      hardware = {
        audio = enabled;
        networking = enabled;
      };

      system = {
        boot = enabled;
        fonts = enabled;
        locale = enabled;
        time = enabled;
        xkb = enabled;
        nix = enabled;
      };

      desktops = {
        hyprland = enabled;
      };

      apps = {
        browser = {
          firefox = enabled;
          brave = enabled;
        };
        cli = {
          helix = enabled;
          fastfetch = enabled;
          krabby = enabled;
        };
        misc = enabled;
        libreoffice = enabled;
        discord = enabled;
        school = {
          latex = enabled;
          cpp = enabled;
        };
        tools = {
          keepassxc = enabled;
          git = enabled;
          zsh = enabled;
          nix-ld = enabled;
          direnv = enabled;
          starship = enabled;
          vscode = enabled;
          emacs = enabled;
        };
      };
    };

    environment.systemPackages = with pkgs.flowstate; [
      sys
      wallpapers
      #scripts
    ];
  };
}
