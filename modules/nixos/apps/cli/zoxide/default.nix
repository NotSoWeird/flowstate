{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.cli.zoxide;
in {
  options.flowstate.apps.cli.zoxide = with types; {
    enable = mkBoolOpt false "Enable or disable zoxide";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ zoxide fzf ]; };
}
