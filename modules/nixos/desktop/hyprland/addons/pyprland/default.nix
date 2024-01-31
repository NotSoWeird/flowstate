{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.desktop.hyprland.addons.pyprland;
in {
  options.flowstate.desktop.hyprland.addons.pyprland = with types; {
    enable = mkBoolOpt false "Enable or disable Pyprland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ pyprland ];

    flowstate = {
      home = { configFile."hypr/pyprland.toml".source = ./pyprland.toml; };
    };
  };
}
