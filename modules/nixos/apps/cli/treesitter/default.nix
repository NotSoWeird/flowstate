{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.cli.treesitter;
in {
  options.flowstate.apps.cli.treesitter = with types; {
    enable = mkBoolOpt false "Enable or disable treesitter";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tree-sitter
      tree-sitter-grammars.tree-sitter-typst
    ];
  };
}
