{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.helix;
in
{
  options.flowstate.apps.helix = with types; {
    enable = mkBoolOpt false "Enable or disable helix";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      EDITOR = "hx";
    };
    environment.systemPackages = with pkgs; [
      helix
    ];

    flowstate.home.configFile."helix/config.toml".source = ./config.toml;
  };
}
