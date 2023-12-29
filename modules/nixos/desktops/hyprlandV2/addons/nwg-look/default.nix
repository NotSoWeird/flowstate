{ options, config, lib, pkgs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktops.hyprlandV2.addons.nwg-look;
in {
  options.flowstate.desktops.hyprlandV2.addons.nwg-look = with types; {
    enable = mkBoolOpt false "Enable or disable nwg-look.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nwg-look ];
    flowstate = { home.configFile = { "nwg-look/config".source = ./config; }; };
  };
}
