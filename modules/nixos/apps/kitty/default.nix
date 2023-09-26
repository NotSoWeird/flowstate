{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.flowstate;
let
  cfg = config.apps.kitty;
in
{
  options.apps.kitty = with types; {
    enable = mkBoolOpt false "Enable the kitty terminal.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gtk3
      kitty
    ];

    home.configFile."kitty/kitty.conf".source = ./kitty.conf;
    home.configFile."kitty/catppuccin".source = ./catppuccin;
    home.configFile."kitty/everforest".source = ./everforest;
  };
}
