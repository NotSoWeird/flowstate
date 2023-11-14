{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.gnupg;
in {
  options.flowstate.apps.tools.gnupg = with types; {
    enable = mkBoolOpt false "Enable gnupg";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pinentry
      pinentry-curses
    ];

    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      pinentryFlavor = "curses";
      enableSSHSupport = true;
    };

    flowstate.home.file.".local/share/gnupg/gpg-agent.conf".source = ./gpg-agent.conf;

    environment.variables = {
      GNUPGHOME = "$XDG_DATA_HOME/gnupg";
    };
  };
}
