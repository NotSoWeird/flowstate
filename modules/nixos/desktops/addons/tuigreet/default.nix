{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.desktops.addons.tuigreet;
in {
  options.flowstate.desktops.addons.tuigreet = with types; {
    enable = mkBoolOpt false "Whether or not to use tuigreet";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };
  };
}
