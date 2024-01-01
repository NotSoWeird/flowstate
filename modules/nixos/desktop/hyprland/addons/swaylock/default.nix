{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland.addons.swaylock;
in {
  options.flowstate.desktop.hyprland.addons.swaylock = with types; {
    enable = mkBoolOpt false "Enable or disable swaylock.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      swaylock-effects
    ];
    flowstate = { 
      home = {
        #configFile = { 
        #  "swaylock/config".source = ./config; 
        #}; 

        configFile."swaylock/config".text = ''
          daemonize
          show-failed-attempts
          clock
          screenshot
          effect-blur=15x15
          effect-vignette=1:1
          color='' + config.lib.stylix.colors.base00 + ''
          font="'' + lib.flowstate.setting.font + ''"
          indicator
          indicator-radius=200
          indicator-thickness=20
          line-color='' + config.lib.stylix.colors.base00 + ''
          ring-color='' + config.lib.stylix.colors.base01 + ''
          inside-color='' + config.lib.stylix.colors.base00 + ''
          key-hl-color='' + config.lib.stylix.colors.base02 + ''
          separator-color=00000000
          text-color='' + config.lib.stylix.colors.base03 + ''
          text-caps-lock-color=""
          line-ver-color='' + config.lib.stylix.colors.base02 + ''
          ring-ver-color='' + config.lib.stylix.colors.base02 + ''
          inside-ver-color='' + config.lib.stylix.colors.base00 + ''
          text-ver-color='' + config.lib.stylix.colors.base03 + ''
          ring-wrong-color='' + config.lib.stylix.colors.base04 + ''
          text-wrong-color='' + config.lib.stylix.colors.base04 + ''
          inside-wrong-color='' + config.lib.stylix.colors.base00 + ''
          inside-clear-color='' + config.lib.stylix.colors.base00 + ''
          text-clear-color='' + config.lib.stylix.colors.base03 + ''
          ring-clear-color='' + config.lib.stylix.colors.base05 + ''
          line-clear-color='' + config.lib.stylix.colors.base00 + ''
          line-wrong-color='' + config.lib.stylix.colors.base00 + ''
          bs-hl-color='' + config.lib.stylix.colors.base04 + ''
          grace=2
          grace-no-mouse
          grace-no-touch
          datestr=%a, %B %e
          timestr=%I:%M %p
          fade-in=0.3
          ignore-empty-password
        '';
      };
    };
    
  };
}
