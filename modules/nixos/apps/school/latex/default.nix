{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.school.latex;
in
{
  options.flowstate.apps.school.latex = with types; {
    enable = mkBoolOpt false "Enable or disable latex.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      tectonic
      texlive.combined.scheme-full
    ];
  };
}
