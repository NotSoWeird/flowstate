{ options, config, lib, pkgs, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland;
in {
  options.flowstate.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    security = {
      pam.services.swaylock = {
        text = ''
          auth include login
        '';
      };
      pam.services.login.enableGnomeKeyring = true;
    };

    services.gnome.gnome-keyring.enable = true;

    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      feh
      killall
      polkit_gnome
      libva-utils
      gsettings-desktop-schemas
      wlr-randr
      wtype
      wl-clipboard
      hyprland-protocols
      hyprpicker
      keepmenu
      gnome.geary
      gnome.nautilus
      pinentry-gnome
      wev
      grim
      slurp
      xdg-utils
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      wlsunset
      pavucontrol
      pamixer
      swayidle
      networkmanagerapplet
    ];

    flowstate = {
      desktop.hyprland.addons = {
        dunst = enabled;
        #fnott = enabled;
        fuzzel = enabled;
        gdm = enabled;
        pyprland = enabled;
        swaylock = enabled;
        swww = enabled;
        waybar = enabled;
        wallpapers = enabled;
      };
    };

    flowstate = {
      home = {
        extraOptions = {
          gtk.cursorTheme = {
            package = pkgs.quintom-cursor-theme;
            name = if (config.lib.stylix.polarity == "light") then
              "Quintom_Ink"
            else
              "Quintom_Snow";
            size = 36;
          };

          wayland.windowManager.hyprland = {
            enable = true;
            extraConfig = ''
              # Monitor
              monitor=eDP-1,3840x2160@60,0x0,2
              #monitor = ,preferred,auto,auto

              # Fix slow startup
              #exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
              #exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

              # Autostart
              exec-once = dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY

              #exec-once = hyprctl setcursor Bibata-Modern-Classic 24
              exec-once = hyprctl setcursor ''
              + config.flowstate.home.extraOptions.gtk.cursorTheme.name + " "
              + builtins.toString
              config.flowstate.home.extraOptions.gtk.cursorTheme.size + ''
                exec-once = dunst

                exec-once = pypr
                exec-once = nm-applet
                exec-once = blueman-applet
                exec-once = emacs --daemon
                exec = pkill waybar & sleep 0.5 && waybar
                exec-once = swww init
                exec-once = wallpaper_random

                exec-once = swayidle -w timeout 90 'swaylock' timeout 210 'suspend-unless-render' resume '$hyprctl dispatch dpms on' before-sleep "swaylock"

                # Input config
                input {
                  kb_layout = se

                  follow_mouse = 1

                  touchpad {
                    natural_scroll = true
                  }

                  kb_options = caps:escape

                  sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
                }

                general {
                  layout = master
                  cursor_inactive_timeout = 30
                  gaps_in = 5
                  gaps_out = 20
                  border_size = 4
                  no_cursor_warps = false
                  col.active_border = 0xff'' + config.lib.stylix.colors.base08
              + "col.inactive_border = 0x33" + config.lib.stylix.colors.base00
              + ''


                  layout = dwindle
                }

                decoration {
                  rounding = 8
                  blur {
                    enabled = true
                    size = 5
                    passes = 2
                    ignore_opacity = true
                    contrast = 1.17
                    brightness = 0.8
                  }
                }


                animations {
                  enabled = yes

                  bezier = ease,0.4,0.02,0.21,1

                  animation = windows, 1, 3.5, ease, slide
                  animation = windowsOut, 1, 3.5, ease, slide
                  animation = border, 1, 6, default
                  animation = fade, 1, 3, ease
                  animation = workspaces, 1, 3.5, ease
                }

                dwindle {
                  pseudotile = yes
                  preserve_split = yes
                }

                master {
                  new_is_master = yes
                }

                gestures {
                  workspace_swipe = false
                }

                # Example windowrule v1
                # windowrule = float, ^(kitty)$
                # Example windowrule v2
                # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

                #windowrule=float,^(kitty)$
                windowrule=float,^(pavucontrol)$
                #windowrule=center,^(kitty)$
                windowrule=float,^(blueman-manager)$
                #windowrule=size 1040 670,^(kitty)$
                windowrule=size 934 525,^(mpv)$
                windowrule=float,^(mpv)$
                windowrule=center,^(mpv)$
                #windowrule=pin,^(firefox)$

                $mainMod = ALT
                bind = $mainMod SHIFT, F, fullscreen,


                #bind = $mainMod, RETURN, exec, cool-retro-term-zsh
                bind = $mainMod, RETURN, exec, kitty
                bind = $mainMod, F, exec, firefox
                bind = $mainMod, Q, killactive,
                bind = $mainMod, M, exit,
                bind = $mainMod, G, exec, nautilus
                bind = $mainMod, V, togglefloating,
                bind = $mainMod, w, exec, fuzzel
                bind = $mainMod, P, pseudo, # dwindle
                bind = $mainMod, J, togglesplit, # dwindle

                bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
                bind = SHIFT, Print, exec, grim -g "$(slurp)"

                # Functional keybinds
                bind =,XF86AudioMicMute,exec,pamixer --default-source -t
                bind =,XF86MonBrightnessDown,exec,light -U 20
                bind =,XF86MonBrightnessUp,exec,light -A 20
                bind =,XF86AudioMute,exec,pamixer -t
                bind =,XF86AudioLowerVolume,exec,pamixer -d 10
                bind =,XF86AudioRaiseVolume,exec,pamixer -i 10
                bind =,XF86AudioPlay,exec,playerctl play-pause
                bind =,XF86AudioPause,exec,playerctl play-pause

                # to switch between windows in a floating workspace
                bind = SUPER,Tab,cyclenext,
                bind = SUPER,Tab,bringactivetotop,

                # Move focus with mainMod + arrow keys
                bind = $mainMod, left, movefocus, l
                bind = $mainMod, right, movefocus, r
                bind = $mainMod, up, movefocus, u
                bind = $mainMod, down, movefocus, d

                # Switch workspaces with mainMod + [0-9]
                bind = $mainMod, 1, workspace, 1
                bind = $mainMod, 2, workspace, 2
                bind = $mainMod, 3, workspace, 3
                bind = $mainMod, 4, workspace, 4
                bind = $mainMod, 5, workspace, 5
                bind = $mainMod, 6, workspace, 6
                bind = $mainMod, 7, workspace, 7
                bind = $mainMod, 8, workspace, 8
                bind = $mainMod, 9, workspace, 9
                bind = $mainMod, 0, workspace, 10

                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                bind = $mainMod SHIFT, 1, movetoworkspace, 1
                bind = $mainMod SHIFT, 2, movetoworkspace, 2
                bind = $mainMod SHIFT, 3, movetoworkspace, 3
                bind = $mainMod SHIFT, 4, movetoworkspace, 4
                bind = $mainMod SHIFT, 5, movetoworkspace, 5
                bind = $mainMod SHIFT, 6, movetoworkspace, 6
                bind = $mainMod SHIFT, 7, movetoworkspace, 7
                bind = $mainMod SHIFT, 8, movetoworkspace, 8
                bind = $mainMod SHIFT, 9, movetoworkspace, 9
                bind = $mainMod SHIFT, 0, movetoworkspace, 10

                # Scroll through existing workspaces with mainMod + scroll
                bind = $mainMod, mouse_down, workspace, e+1
                bind = $mainMod, mouse_up, workspace, e-1

                # Move/resize windows with mainMod + LMB/RMB and dragging
                bindm = $mainMod, mouse:272, movewindow
                bindm = $mainMod, mouse:273, resizewindow
                #bindm = ALT, mouse:272, resizewindow

                bind=$mainMod, Z, exec, pypr toggle kitty && hyprctl dispatch bringactivetotop
                bind=$mainMod, X,exec,pypr toggle volume && hyprctl dispatch bringactivetotop
                bind=$mainMod, B,exec,pypr toggle btm && hyprctl dispatch bringactivetotop
                $scratchpadsize = size 80% 85%

                $scratchpad = class:^(scratchpad)$
                windowrulev2 = float,$scratchpad
                windowrulev2 = $scratchpadsize,$scratchpad
                windowrulev2 = workspace special silent,$scratchpad
                windowrulev2 = center,$scratchpad

                $gearyscratchpad = class:^(geary)$
                windowrulev2 = float,$gearyscratchpad
                windowrulev2 = $scratchpadsize,$gearyscratchpad
                windowrulev2 = workspace special silent,$gearyscratchpad
                windowrulev2 = center,$gearyscratchpad

                bind=SUPERCTRL,right,workspace,+1
                bind=SUPERCTRL,left,workspace,-1

              '';
            xwayland = { enable = true; };
            systemd.enable = true;
          };
        };

        #configFile."hypr/" = {
        #  source = ./hypr;
        #  recursive = true;
        #};

        configFile."hypr/pyprland.json".text = ''
          {
            "pyprland": {
              "plugins": ["scratchpads", "magnify"]
            },
            "scratchpads": {
              "term": {
                "command": "alacritty --class scratchpad",
                "margin": 50
              },
              "ranger": {
                "command": "kitty --class scratchpad -e ranger",
                "margin": 50
              },
              "musikcube": {
                "command": "alacritty --class scratchpad -e musikcube",
                "margin": 50
              },
              "btm": {
                "command": "alacritty --class scratchpad -e btm",
                "margin": 50
              },
              "geary": {
                "command": "geary",
                "margin": 50
              },
              "pavucontrol": {
                "command": "pavucontrol",
                "margin": 50,
                "unfocus": "hide",
                "animation": "fromTop"
              }
            }
          }
        '';
      };
    };
  };
}
