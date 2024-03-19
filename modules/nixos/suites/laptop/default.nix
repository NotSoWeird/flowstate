{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.suites.laptop;
in {
  options.flowstate.suites.laptop = with types; {
    enable =
      mkBoolOpt false "whether or not to enable the laptop configuration.";
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
        browser = {
          firefox = enabled;
          qutebrowser = enabled;
        };
        cli = {
          fastfetch = enabled;
          krabby = enabled;
          onefetch = enabled;
          starship = enabled;
          wget = enabled;
          zoxide = enabled;
        };
        editor = {
          vscode = enabled;
          doom-emacs = enabled;
        };
        gaming = {
          lutris = enabled;
          gamemode = enabled;
        };
        shell.zsh = enabled;
        terminal = {
          kitty = enabled;
          xfce4-terminal = enabled;
        };
        misc = enabled;
        media = {
          spotify = enabled;
          nuclear = enabled;
          termusic = enabled;
        };
        chat = {
          teams = enabled;
          slack = enabled;
          discord = enabled;
        };
        school = {
          anki = enabled;
          typst = enabled;
          latex = enabled;
        };
        tools = {
          libreoffice = enabled;
          direnv = enabled;
          git = enabled;
          keepassxc = enabled;
          qemu = enabled;
          distrobox = enabled;
          gcc = enabled;
          tangram = enabled;
          freecad = enabled;
          #blender = enabled;
        };
      };
      stylix = enabled;
      desktop.hyprland = enabled;
    };

    environment.systemPackages = with pkgs; [
      flowstate.wallpapers
      (writeShellScriptBin "wallpaper_random" ''
        if command -v swww >/dev/null 2>&1; then
            swww img $(find ~/Pictures/wallpapers/. -regex '.*\(.png\|.jpg\|.gif\)$'  | shuf -n1) --transition-type random
        fi
      '')
    ];
  };
}
