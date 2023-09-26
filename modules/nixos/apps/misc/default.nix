{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.apps.misc;
in
{
  options.apps.misc = with types; {
    enable = mkBoolOpt false "Enable or disable misc apps";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Development
      git
      bat
      eza
      fzf
      fd

      # Util
      unzip
      sshfs
      btop
      ffmpeg
      python3
      wl-clipboard
    ];
  };
}
