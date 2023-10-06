{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.cli.fastfetch;
in
{
  options.flowstate.apps.cli.fastfetch = with types; {
    enable = mkBoolOpt false "Enable or disable fastfetch";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fastfetch
    ];

    # flowstate.home.configFile."helix/config.toml".source = ./config.toml;
  };
}
