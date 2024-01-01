{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.suites.laptop;
in {
  options.flowstate.suites.laptop = with types; {
    enable = mkBoolOpt false "whether or not to enable the laptop configuration.";
  };

  config = mkIf cfg.enable {
    flowstate = {
      system = {
        boot = enabled;
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
        #power = enabled;
      };

      apps = {
        browser.firefox = enabled;
        shell.zsh = enabled;
        discord = enabled;
        doom-emacs = enabled;
        terminal.kitty = enabled;
        misc = enabled;

        school = {
          #cpp = enabled;
          latex = enabled;
        };
        tools = {
          direnv = enabled;
          git = enabled;
          vscode = enabled;
          keepassxc = enabled;
        };
      };
      stylix = enabled;
      desktop.hyprland = enabled;
    };

    environment.systemPackages = with pkgs.flowstate; [
      wallpapers
    ];
  };
}
