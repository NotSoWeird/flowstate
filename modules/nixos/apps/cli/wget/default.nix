{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.cli.wget;
in {
  options.flowstate.apps.cli.wget = with types; {
    enable = mkBoolOpt false "Enable or disable wget";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wget ];

    flowstate.home.configFile."wgetrc".text = "";
  };
}
