{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.school.typst;
in {
  options.flowstate.apps.school.typst = with types; {
    enable = mkBoolOpt false "Enable or disable typst.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ typst typst-lsp ];
  };
}
